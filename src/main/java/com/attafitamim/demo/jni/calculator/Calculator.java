package com.attafitamim.demo.jni.calculator;

public class Calculator {
    static {
        System.loadLibrary("calculator");
    }

    public native int add(int a, int b);
    public native int subtract(int a, int b);
    public native int multiply(int a, int b);
    public native int divide(int a, int b);
} 