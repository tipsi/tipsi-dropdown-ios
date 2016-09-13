package com.gettipsi.testmodule.matcher;

import android.view.View;
import android.widget.AdapterView;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

public class DropdownMatcher {

    public static Matcher<View> withListSize(final int size) {
        return new TypeSafeMatcher<View>() {
            int length;

            @Override
            public boolean matchesSafely(final View view) {
                length = ((AdapterView) view).getAdapter().getCount();
                return length == size;
            }

            @Override
            public void describeTo(final Description description) {
                description.appendText("ListView should have " + size + " items, the actual size is " + length);
            }
        };
    }
}
