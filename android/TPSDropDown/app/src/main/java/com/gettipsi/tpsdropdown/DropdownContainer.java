package com.gettipsi.tpsdropdown;

import android.content.Context;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.FrameLayout;

public class DropdownContainer extends FrameLayout {

    private Dropdown dropdown;

    public DropdownContainer(Context context) {
        super(context);
        initDropdown();
    }

    public DropdownContainer(Context context, AttributeSet attrs) {
        super(context, attrs);
        initDropdown();
    }

    public DropdownContainer(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initDropdown();
    }

    private void initDropdown() {
        dropdown = new Dropdown(getContext());
        ViewGroup.LayoutParams params = new LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT, Gravity.START);
        dropdown.setId(R.id.dropdownId);
        dropdown.setLayoutParams(params);
        addView(dropdown);
    }

    public Dropdown getDropdown() {
        return dropdown;
    }
}
