package com.gettipsi.testmodule.action;

import android.support.test.espresso.UiController;
import android.support.test.espresso.ViewAction;
import android.support.test.espresso.matcher.ViewMatchers;
import android.view.View;

import com.gettipsi.tpsdropdown.Dropdown;

import org.hamcrest.Matcher;

public class SelectElementWithNameAction implements ViewAction {

    private String name;

    public SelectElementWithNameAction(String name) {
        this.name = name;
    }

    @Override
    public Matcher<View> getConstraints() {
        return ViewMatchers.isAssignableFrom(Dropdown.class);
    }

    @Override
    public String getDescription() {
        return "SelectElementWithNameAction";
    }

    @Override
    public void perform(UiController uiController, View view) {
        ((Dropdown) view).selectElementWithName(name);
    }
}
