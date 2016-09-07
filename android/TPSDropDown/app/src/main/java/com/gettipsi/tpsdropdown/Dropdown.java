package com.gettipsi.tpsdropdown;

import android.content.Context;
import android.os.SystemClock;
import android.support.v7.widget.AppCompatSpinner;
import android.view.View;
import android.widget.AdapterView;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;

public class Dropdown extends AppCompatSpinner {

    private Context context;
    private boolean firstEventFired = false;
    private int selectedIndex = 0;
    private int selected = 0;

    public Dropdown(ThemedReactContext context) {
        super(context, 0);
        this.context = context;
        setOnItemSelectedListener(ON_ITEM_SELECTED_LISTENER);
    }

    public void setValues(ReadableArray values) {
        Adapter spinnerArrayAdapter = new Adapter(context,
                android.R.layout.simple_spinner_item, Converter.toList(values));
        spinnerArrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        setAdapter(spinnerArrayAdapter);
        setSelection(selectedIndex);
    }

    public void setSelected(int selected) {
        if (selected == selectedIndex && selected == this.selected) {
            return;
        }
        selectedIndex = selected;
        setSelection(selectedIndex);
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
                    ReactContext reactContext = (ReactContext) view.getContext();
                    reactContext
                            .getNativeModule(UIManagerModule.class)
                            .getEventDispatcher().dispatchEvent(
                            new DropdownEvent(
                                    getId(),
                                    SystemClock.uptimeMillis(),
                                    pos,
                                    parent.getSelectedItem().toString()));
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
}