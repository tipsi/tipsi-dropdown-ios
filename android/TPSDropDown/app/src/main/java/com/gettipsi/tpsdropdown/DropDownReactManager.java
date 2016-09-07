package com.gettipsi.tpsdropdown;

import android.support.annotation.Nullable;
import android.widget.ArrayAdapter;
import android.widget.SpinnerAdapter;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewProps;
import com.facebook.react.uimanager.annotations.ReactProp;

public class DropDownReactManager extends SimpleViewManager<DropdownContainer> {

    private static final String REACT_CLASS_NAME = "TPSDropDown";

    private Dropdown dropdown;

    @Override
    public String getName() {
        return REACT_CLASS_NAME;
    }

    @Override
    protected DropdownContainer createViewInstance(final ThemedReactContext reactContext) {
        DropdownContainer dropdownContainer = new DropdownContainer(reactContext);
        dropdown = dropdownContainer.getDropdown();
        return dropdownContainer;
    }

    @ReactProp(name = "items")
    public void setItems(DropdownContainer dropdown, ReadableArray items) {
        dropdown.getDropdown().setValues(items);
    }

    @ReactProp(name = "selected")
    public void setSelected(DropdownContainer dropdown, int selected) {
        dropdown.getDropdown().setSelected(selected);
    }

    @ReactProp(name = ViewProps.BACKGROUND_COLOR)
    public void setBackgroundColor(DropdownContainer dropdownContainer, @Nullable  String color) {

    }

    @ReactMethod
    public void selectElementWithName(String name) {
        int index = 0;
        SpinnerAdapter adapter = (ArrayAdapter) dropdown.getAdapter();
        for (int i = 0; i < adapter.getCount(); i++) {
            if (adapter.getItem(i).toString().equals(name)) {
                index = i;
                break;
            }
        }
        dropdown.setSelected(index);
    }

    @ReactMethod
    public void pickElementAtIndex(int index) {
        dropdown.setSelected(index);
    }

    @ReactMethod
    public void closeDropdown() {
        dropdown.clearFocus();
    }

    @ReactMethod
    public void resetFirstElement() {
        dropdown.setSelected(0);
    }

    @ReactMethod
    public void getCurrentItem(Callback callback) {
        callback.invoke(dropdown.getSelectedItem().toString());
    }

    @ReactMethod
    public void elementHeight(Callback callback) {
        callback.invoke(dropdown.getMeasuredHeight());
    }

}
