package com.example.weiweili.gridunlock;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.io.FileOutputStream;

public class DisplayBigSix extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_display_big_six);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        Intent intent = getIntent();
        String message = intent.getStringExtra(BigSix.EXTRA_MESSAGE);
        TextView textView = new TextView(this);
        textView.setTextSize(10);
        textView.setText(message);

        RelativeLayout layout = (RelativeLayout) findViewById(R.id.content2);
        layout.addView(textView);

        String filename = "myfile";
        String string = message;
        string = "------Ci-dessous est le résultat de BigSix------\n"+string+"-------Ci-dessus est la suite de BigSix-------\n";
        FileOutputStream outputStream;

        try {
            outputStream = openFileOutput(filename, Context.MODE_APPEND);
            outputStream.write(string.getBytes());
            outputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public void next(View view){
        Intent intent = new Intent(this, SmallTen.class);
        startActivity(intent);

    }


}
