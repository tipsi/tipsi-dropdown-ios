package com.gettipsi.testmodule.action;

import android.support.test.espresso.UiController;
import android.support.test.espresso.ViewAction;
import android.support.test.espresso.matcher.ViewMatchers;
import android.view.View;

import com.gettipsi.tpsdropdown.Dropdown;

import org.hamcrest.Matcher;

import java.util.List;

public class SetupElementsAction implements ViewAction {

    private List<Object> items;

    public SetupElementsAction(List<Object> items) {
        this.items = items;
    }

    @Override
    public Matcher<View> getConstraints() {
        return ViewMatchers.isAssignableFrom(Dropdown.class);
    }

    @Override
    public String getDescription() {
        return "SetupElementsAction";
    }

    @Override
    public void perform(UiController uiController, View view) {
        Dropdown dropdown = (Dropdown) view;
        dropdown.setupWithElements(items);
    }
}
