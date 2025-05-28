#include "com_attafitamim_demo_jni_calculator_Calculator.h"

JNIEXPORT jint JNICALL Java_com_attafitamim_demo_jni_calculator_Calculator_add(JNIEnv *env, jobject obj, jint a, jint b) {
    return a + b;
}

JNIEXPORT jint JNICALL Java_com_attafitamim_demo_jni_calculator_Calculator_subtract(JNIEnv *env, jobject obj, jint a, jint b) {
    return a - b;
}

JNIEXPORT jint JNICALL Java_com_attafitamim_demo_jni_calculator_Calculator_multiply(JNIEnv *env, jobject obj, jint a, jint b) {
    return a * b;
}

JNIEXPORT jint JNICALL Java_com_attafitamim_demo_jni_calculator_Calculator_divide(JNIEnv *env, jobject obj, jint a, jint b) {
    if (b == 0) {
        jclass arithmeticException = (*env)->FindClass(env, "java/lang/ArithmeticException");
        if (arithmeticException != NULL) {
            (*env)->ThrowNew(env, arithmeticException, "Division by zero");
        }
        return 0; // This value is ignored if an exception is thrown
    }
    return a / b;
}
