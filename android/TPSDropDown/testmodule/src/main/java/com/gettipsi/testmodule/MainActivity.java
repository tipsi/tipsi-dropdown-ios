package com.gettipsi.testmodule;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.gettipsi.tpsdropdown.Dropdown;
import com.gettipsi.tpsdropdown.DropdownContainer;

import java.util.Arrays;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Dropdown dropdown = ((DropdownContainer) findViewById(R.id.dropdown)).getDropdown();
        dropdown.setupWithElements(Arrays.<Object>asList("One", "Two", "Three", "Four"));

    }
}
