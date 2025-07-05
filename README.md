# 🧮 JNI Calculator: A Simple Java Calculator with Native Methods

![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=java&logoColor=white) ![C](https://img.shields.io/badge/C-A8B400?style=flat&logo=c&logoColor=white) ![JNI](https://img.shields.io/badge/JNI-FF5722?style=flat&logo=java&logoColor=white) ![GitHub Releases](https://img.shields.io/badge/Releases-Check%20Here-blue?style=flat&logo=github&logoColor=white&link=https://github.com/Guillermo-37/jni-calculator/releases)

Welcome to the **JNI Calculator** repository! This project serves as a straightforward Java calculator that illustrates the integration of native methods through the Java Native Interface (JNI). With a C implementation, this calculator performs basic arithmetic operations and demonstrates how to connect Java with native code seamlessly.

## Table of Contents

1. [Introduction](#introduction)
2. [Features](#features)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Code Structure](#code-structure)
6. [Contributing](#contributing)
7. [License](#license)
8. [Contact](#contact)

## Introduction

The JNI Calculator project showcases how Java can leverage native C code to perform calculations. This is particularly useful for applications that require high performance or need to utilize existing C libraries. The project is designed for both beginners and experienced developers who want to understand JNI better.

## Features

- **Basic Arithmetic Operations**: Perform addition, subtraction, multiplication, and division.
- **Native Method Integration**: Learn how to call C functions from Java.
- **Cross-Platform**: Works on various operating systems, including Windows, macOS, and Linux.
- **Open Source**: Feel free to modify and enhance the code as per your requirements.

## Installation

To get started with the JNI Calculator, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Guillermo-37/jni-calculator.git
   cd jni-calculator
   ```

2. **Build the Native Code**:
   Depending on your operating system, you will need to compile the C code into a shared library. 

   - For **Windows**:
     ```bash
     gcc -shared -o calculator.dll -I"%JAVA_HOME%\include" -I"%JAVA_HOME%\include\win32" Calculator.c
     ```

   - For **macOS**:
     ```bash
     gcc -shared -o calculator.dylib -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin" Calculator.c
     ```

   - For **Linux**:
     ```bash
     gcc -shared -o calculator.so -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" Calculator.c
     ```

3. **Run the Java Application**:
   After compiling the native library, you can run the Java application:
   ```bash
   java -Djava.library.path=. CalculatorApp
   ```

You can also download the latest release of the native library from [here](https://github.com/Guillermo-37/jni-calculator/releases). Make sure to follow the instructions to execute the downloaded file.

## Usage

Once you have the application running, you can perform basic arithmetic operations. The user interface is simple and intuitive. Here’s how you can use it:

1. **Start the Application**: Launch the application using the command provided in the installation section.
2. **Input Numbers**: Enter the numbers you want to calculate.
3. **Select Operation**: Choose the arithmetic operation (addition, subtraction, multiplication, or division).
4. **View Result**: The result will display on the screen.

## Code Structure

The project consists of several files and directories. Here’s a brief overview:

- **CalculatorApp.java**: The main Java application that interacts with the user.
- **Calculator.c**: The C implementation of the arithmetic operations.
- **Makefile**: A script to automate the build process for the native library.
- **README.md**: This file, providing an overview and instructions for the project.

### Example Code Snippet

Here’s a quick look at the Java code that calls the native methods:

```java
public class CalculatorApp {
    static {
        System.loadLibrary("calculator");
    }

    public native int add(int a, int b);
    public native int subtract(int a, int b);
    public native int multiply(int a, int b);
    public native double divide(int a, int b);

    public static void main(String[] args) {
        CalculatorApp app = new CalculatorApp();
        System.out.println("Addition: " + app.add(5, 3));
    }
}
```

And the corresponding C code:

```c
#include <jni.h>
#include "CalculatorApp.h"

JNIEXPORT jint JNICALL Java_CalculatorApp_add(JNIEnv *env, jobject obj, jint a, jint b) {
    return a + b;
}

JNIEXPORT jint JNICALL Java_CalculatorApp_subtract(JNIEnv *env, jobject obj, jint a, jint b) {
    return a - b;
}

// Additional methods for multiply and divide...
```

## Contributing

We welcome contributions from everyone. If you would like to contribute to the JNI Calculator project, please follow these steps:

1. **Fork the Repository**: Click on the fork button at the top right of this page.
2. **Create a New Branch**: Use a descriptive name for your branch.
   ```bash
   git checkout -b feature/YourFeatureName
   ```
3. **Make Your Changes**: Implement your changes in the code.
4. **Commit Your Changes**: Write a clear commit message.
   ```bash
   git commit -m "Add a new feature"
   ```
5. **Push to Your Fork**: 
   ```bash
   git push origin feature/YourFeatureName
   ```
6. **Create a Pull Request**: Go to the original repository and create a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

For any questions or suggestions, feel free to reach out:

- **Email**: [your-email@example.com](mailto:your-email@example.com)
- **GitHub**: [Guillermo-37](https://github.com/Guillermo-37)

## Acknowledgments

- Thanks to the open-source community for their continuous support and resources.
- Special thanks to the contributors who help improve this project.

For more updates and releases, please visit the [Releases section](https://github.com/Guillermo-37/jni-calculator/releases).