package com.attafitamim.demo.jni.calculator;

public class Main {
    public static void main(String[] args) {
        System.out.println("Running calculator");
        Calculator calc = new Calculator();
        System.out.println("Add: 3 + 2 = " + calc.add(3, 2));
        System.out.println("Subtract: 3 - 2 = " + calc.subtract(3, 2));
        System.out.println("Multiply: 3 * 2 = " + calc.multiply(3, 2));
        System.out.println("Divide: 6 / 2 = " + calc.divide(6, 2));
        System.out.print("Divide: 6 / 0 = ");
        try {
            System.out.println(calc.divide(6, 0));
        } catch (Exception e) {
            System.out.println("Error: " + e.toString());
        }
    }
} 