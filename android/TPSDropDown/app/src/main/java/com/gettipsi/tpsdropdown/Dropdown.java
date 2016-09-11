package com.gettipsi.tpsdropdown;

import android.content.Context;
import android.support.v7.widget.AppCompatSpinner;
import android.view.View;
import android.widget.AdapterView;
import android.widget.SpinnerAdapter;

import java.util.List;

public class Dropdown extends AppCompatSpinner {

    private Context context;
    private boolean firstEventFired = false;
    private int selectedIndex = 0;
    private int selected = 0;
    private DropdownUpdateEvent dropdownUpdateEvent;

    public Dropdown(Context context) {
        super(context, 0);
        this.context = context;
        setOnItemSelectedListener(ON_ITEM_SELECTED_LISTENER);
    }

    public void setDropdownUpdateEvent(DropdownUpdateEvent dropdownUpdateEvent) {
        this.dropdownUpdateEvent = dropdownUpdateEvent;
    }

    public void setupWithElements(List<Object> values) {
        final Adapter spinnerArrayAdapter = new Adapter(context,
                android.R.layout.simple_spinner_item, values);
        spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        post(new Runnable() {
            @Override
            public void run() {
                setAdapter(spinnerArrayAdapter);
                setSelection(selectedIndex);
            }
        });
    }

    public void selectElementWithName(String name) {
        SpinnerAdapter adapter = getAdapter();
        if (adapter != null) {
            int index = 0;
            for (int i = 0; i < adapter.getCount(); i++) {
                if (adapter.getItem(i).toString().equals(name)) {
                    index = i;
                    break;
                }
            }
            setSelected(index);
        }
    }

    public void setSelected(final int selected) {
        post(new Runnable() {
            @Override
            public void run() {
                if (selected == selectedIndex && selected == Dropdown.this.selected) {
                    return;
                }
                selectedIndex = selected;
                setSelection(selectedIndex);
            }
        });
    }

    private final OnItemSelectedListener ON_ITEM_SELECTED_LISTENER =
            new OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                    selected = pos;
                    if (!firstEventFired) {
                        firstEventFired = true;
                        return;
                    }
                    if (dropdownUpdateEvent != null) {
                        dropdownUpdateEvent.onUpdate(view, getId(), pos, parent.getSelectedItem().toString());
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {
                }
            };

    private final Runnable mLayoutRunnable = new Runnable() {
        @Override
        public void run() {
            measure(MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.EXACTLY),
                    MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.EXACTLY));
            layout(getLeft(), getTop(), getRight(), getBottom());
        }
    };

    @Override
    public void requestLayout() {
        super.requestLayout();
        post(mLayoutRunnable);
    }

    public interface DropdownUpdateEvent {
        void onUpdate(View view, int id, int pos, String selectedItem);
    }
}