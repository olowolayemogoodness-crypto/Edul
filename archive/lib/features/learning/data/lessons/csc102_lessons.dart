// lib/features/learning/data/lessons/csc102_lessons.dart

Map<String, dynamic> getCSC102LessonData(String lessonId) {
  switch (lessonId) {
    case 'csc102_u1_1':
      return {
        'content': '''# Computer Overview

## What is a Computer?

A computer is an electronic device that processes data into information. It accepts input, processes it using programs, and produces meaningful output.

## The Basic Computer Cycle

Every computer follows this cycle:
1. **Input**: Data enters the system
2. **Processing**: Data is manipulated by the CPU
3. **Output**: Results are displayed or stored
4. **Storage**: Data is permanently saved

## Key Characteristics of Computers

✓ **Speed**: Operates in nanoseconds (billionths of a second)
✓ **Accuracy**: Minimal computational errors
✓ **Reliability**: Consistent performance across time
✓ **Storage Capacity**: Can store vast amounts of data
✓ **Programmability**: Can be instructed to perform various tasks
✓ **Automation**: Executes tasks without human intervention

## Types of Computers

• **Supercomputers**: Highest processing power for scientific calculations
• **Mainframes**: Large-scale processing for enterprises
• **Mini-computers**: Mid-range processing capability
• **Micro-computers**: Personal computers, laptops, mobile devices

## Generations of Computers

- **1st Generation (1946-1956)**: Vacuum tubes
- **2nd Generation (1956-1963)**: Transistors
- **3rd Generation (1963-1971)**: Integrated Circuits (ICs)
- **4th Generation (1971-present)**: Microprocessors
- **5th Generation (present & future)**: AI, Machine Learning, Quantum Computing''',
        'questions': [
          {
            'question': 'What is a computer?',
            'options': ['A calculating machine', 'An electronic device that processes data into information', 'A storage device', 'An input device'],
            'correct': 1,
          },
          {
            'question': 'The basic computer cycle is:',
            'options': ['Input-Processing-Output-Storage', 'Storage-Input-Processing-Output', 'Processing-Output-Input-Storage', 'Output-Storage-Input-Processing'],
            'correct': 0,
          },
          {
            'question': 'Which is NOT a characteristic of computers?',
            'options': ['Speed', 'Accuracy', 'Consciousness', 'Reliability'],
            'correct': 2,
          },
          {
            'question': 'Computers can operate at speeds measured in:',
            'options': ['Milliseconds', 'Microseconds', 'Nanoseconds', 'All of above depending on type'],
            'correct': 2,
          },
          {
            'question': 'The first generation of computers used:',
            'options': ['Microprocessors', 'Transistors', 'Vacuum tubes', 'Integrated circuits'],
            'correct': 2,
          },
        ]
      };

    case 'csc102_u1_2':
      return {
        'content': '''# Computer Hardware Subsystems

## The CPU: The Brain of the Computer

The Central Processing Unit (CPU) executes all instructions and controls the entire computer. It operates at speeds measured in GHz (Gigahertz) — billions of cycles per second.

## Components of the CPU

• **ALU (Arithmetic Logic Unit)**: Performs arithmetic and logical operations
• **Control Unit**: Decodes instructions from memory and directs execution
• **Registers**: Ultra-fast temporary storage (nanosecond access)

## Memory Systems

### Primary Memory (RAM)
• Volatile: Lost when power is turned off
• Fast access speed: Nanosecond response
• Temporary workspace: For running programs and data
• Measured in GB: Modern PCs have 8-32 GB

### Read-Only Memory (ROM)
• Permanent, non-volatile: Retains data when powered off
• Contains firmware: Boot instructions and BIOS
• Cannot be easily modified: Protects critical startup code

### Cache Memory
• Smaller and faster than RAM: Microsecond access
• Multiple levels: L1 (smallest, fastest), L2, L3

### Secondary Storage
• **HDD**: Spinning magnetic disks, high capacity, slower access
• **SSD**: No moving parts, fast access, more durable

## Input & Output Devices

**Input**: Keyboard, Mouse, Scanner, Microphone, Touchscreen

**Output**: Monitor, Printer, Speaker, Projector''',
        'questions': [
          {
            'question': 'The CPU stands for:',
            'options': ['Central Processing Unit', 'Central Peripheral Unit', 'Control Processing Utility', 'Computer Personal Unit'],
            'correct': 0,
          },
          {
            'question': 'The ALU in a CPU performs:',
            'options': ['Arithmetic operations', 'Logical operations', 'Both arithmetic and logical', 'Memory operations'],
            'correct': 2,
          },
          {
            'question': 'RAM is:',
            'options': ['Random Access Memory', 'Read-only Memory', 'Volatile temporary storage', 'Both A and C'],
            'correct': 3,
          },
          {
            'question': 'Which memory type is lost when power is off?',
            'options': ['ROM', 'RAM', 'Hard disk', 'Flash drive'],
            'correct': 1,
          },
          {
            'question': 'SSD advantages over HDD include:',
            'options': ['No moving parts', 'Faster data access', 'More durable', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u1_3':
      return {
        'content': '''# Computer Software Subsystems

## System Software: The OS

The Operating System (OS) is the bridge between hardware and applications. It manages all resources and provides a platform for running programs.

## Major Operating Systems

• **Windows**: Microsoft's proprietary OS, dominant on PCs
• **macOS**: Apple's OS, exclusive to Mac computers
• **Linux**: Open-source, free OS, powers servers and embedded systems
• **iOS/Android**: Mobile operating systems

## OS Functions

✓ **Hardware Management**: Controls CPU, memory, storage, peripherals
✓ **Resource Allocation**: Distributes CPU time and memory to programs
✓ **Process Management**: Handles multitasking (multiple programs running)
✓ **File Management**: Organizes files in folders/directories
✓ **Security**: User authentication, permissions, malware prevention

## Device Drivers

Device drivers enable communication between the OS and hardware devices:
- Printer drivers print documents
- Graphics drivers render video
- Network drivers enable internet connection
- Must match both OS and hardware

## Application Software

### Productivity Suite
- Word Processors: Microsoft Word, Google Docs
- Spreadsheets: Excel, Google Sheets
- Presentations: PowerPoint, Keynote
- Database Programs: Access, MySQL

### Utility Software
- **Antivirus**: Protect from malware and viruses
- **Compression**: WinRAR, 7-Zip (reduce file size)
- **Backup**: Automated data protection
- **Disk Cleanup**: Remove temporary files''',
        'questions': [
          {
            'question': 'An operating system is:',
            'options': ['System software managing hardware', 'Controlling resources and processes', 'Interface between user and hardware', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Which is an example of an operating system?',
            'options': ['Windows', 'macOS', 'Linux', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Device drivers are:',
            'options': ['Software that enables communication with hardware', 'Necessary for peripherals to work', 'Hardware-dependent', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Application software includes:',
            'options': ['Word processors', 'Spreadsheets', 'Database programs', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'A virus in software is:',
            'options': ['Malicious code that replicates', 'Infects other programs', 'Can damage data', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u2_1':
      return {
        'content': '''# Programming Language Basics

## What is a Programming Language?

A programming language is a formal system for communicating instructions to computers. It uses precise syntax (grammar rules) and semantics (meaning) that the computer can understand and execute.

## Language Levels

### Low-Level Languages
• **Machine Language**: Pure binary (0s and 1s), only language CPU understands
• **Assembly**: Uses mnemonics (MOV, ADD, JMP) instead of binary
• Characteristics: Machine-dependent, efficient, but very difficult to write

### Mid-Level Languages
• **C, C++**: Balance between efficiency and abstraction
• Direct memory access: Pointers allow direct memory manipulation

### High-Level Languages
• **Python, Java, C#, JavaScript**: Human-readable syntax
• Platform-independent: Write once, run anywhere
• Easier to learn: More abstract from hardware details

## Programming Paradigms

### Procedural Programming
- Step-by-step instruction sequences (BASIC, C, Pascal)
- Focus on "HOW" to solve a problem

### Object-Oriented Programming (OOP)
- Objects, Classes, Inheritance, Polymorphism
- Java, C++, C#, Python support OOP

### Functional Programming
- Functions, immutability, no side effects
- Lisp, Scheme, Haskell, Scala

### Scripting Languages
- Rapid development, interpreted
- Python, JavaScript, PHP, Ruby''',
        'questions': [
          {
            'question': 'A programming language is:',
            'options': ['Communication method with computers', 'Set of syntax rules and semantics', 'Instructions written in formal notation', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Assembly language is:',
            'options': ['Low-level language', 'Machine-dependent', 'Uses mnemonics for instructions', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'High-level languages include:',
            'options': ['Python', 'Java', 'C++', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Procedural programming means:',
            'options': ['Step-by-step instruction sequence', 'Following procedures/functions', 'Imperative style', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Object-oriented programming features:',
            'options': ['Objects and classes', 'Inheritance', 'Polymorphism', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u2_2':
      return {
        'content': '''# BASIC Programming Language

## History & Purpose

BASIC stands for "Beginner's All-purpose Symbolic Instruction Code" and was developed in the 1960s by Kemeny and Kurtz at Dartmouth College. It was designed to teach programming to non-computer scientists.

## Key Characteristics

✓ **Line Numbers**: Programs used line numbers (10, 20, 30, ...) for organization
✓ **Simple Syntax**: Extremely easy to learn, minimal punctuation
✓ **Immediate Mode**: Type commands and see results instantly
✓ **Direct Mode**: Line-by-line input and output

## Core BASIC Statements

### REM (Remark)
REM This is a comment - ignored by the interpreter

### LET (Assignment)
LET x = 5 or y = 10 (optional LET keyword)

### INPUT (Reading Data)
INPUT "Enter your name: ", name

### PRINT (Output)
PRINT "Hello World" or PRINT x, y, z

### FOR...NEXT (Loop)
FOR i = 1 TO 10
  PRINT i
NEXT i

### IF...THEN...ELSE (Conditional)
IF x > 5 THEN PRINT "Greater"
ELSE PRINT "Smaller"

### GOTO (Jump)
GOTO 100

### END (Termination)
END

## Data Types in BASIC

• **INTEGER**: Whole numbers (-100, 0, 42)
• **REAL**: Decimal numbers (3.14, 2.718)
• **STRING**: Text data''',
        'questions': [
          {
            'question': 'BASIC stands for:',
            'options': ['Beginner\'s All-purpose Symbolic Instruction Code', 'Basic Algorithm System for Instruction Code', 'Beginner Automatic System Instruction Code', 'Basic Applied Science Instruction Code'],
            'correct': 0,
          },
          {
            'question': 'BASIC was developed in:',
            'options': ['1960s', '1950s', '1970s', '1980s'],
            'correct': 0,
          },
          {
            'question': 'BASIC programs used:',
            'options': ['Line numbers', 'Sequential instructions', 'Both A and B', 'Labels only'],
            'correct': 2,
          },
          {
            'question': 'GOTO statement in BASIC:',
            'options': ['Transfers control to line number', 'Considered poor practice now', 'Creates spaghetti code', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'REM in BASIC is:',
            'options': ['Remark/Comment', 'Ignored by interpreter', 'Documents code', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u2_3':
      return {
        'content': '''# Visual Basic Programming

## Visual Basic.NET

Visual Basic is the modern, object-oriented successor to BASIC. It runs on the .NET Framework and allows developers to create sophisticated Windows applications with graphical user interfaces (GUIs).

## Development Environment

### Visual Studio IDE
- Complete integrated development environment
- Drag-and-drop UI designer
- Code editor with IntelliSense (intelligent code completion)
- Built-in debugger

### Windows Forms
- Create desktop applications with graphical interfaces
- Drag controls onto forms visually
- No need to code UI layout manually

## Core Concepts

### Forms
- GUI windows that users interact with
- Contain controls (buttons, textboxes, labels)
- Respond to user events
- Properties control appearance

### Controls (UI Elements)
• **Button**: Clickable element triggering Click event
• **TextBox**: User input field with Text property
• **Label**: Display text (read-only)
• **ListBox**: Display list of items
• **ComboBox**: Dropdown list with text input
• **CheckBox**: Toggle on/off (Checked property)
• **RadioButton**: Mutually exclusive options
• **PictureBox**: Display images
• **DataGridView**: Display tabular data

### Events
Events occur when users interact with controls:
- Click: User clicks button or control
- Load: Form initializes
- KeyPress: User presses keyboard key
- TextChanged: Text in TextBox changes
- SelectedIndexChanged: Selection in ListBox changes

### Properties
Every control has properties:
- **Name**: Identifier for control
- **Text**: Displayed text or user input
- **BackColor/ForeColor**: Background and text colors
- **Enabled**: Whether user can interact
- **Visible**: Whether control is shown
- **Size**: Width and height''',
        'questions': [
          {
            'question': 'Visual Basic is:',
            'options': ['Successor to BASIC', 'Event-driven programming', 'GUI-based development', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'VB.NET runs on:',
            'options': ['.NET Framework', 'Windows', 'Can run on Linux via .NET Core', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Forms in Visual Basic are:',
            'options': ['GUI windows', 'Contain controls', 'Respond to events', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Controls in Visual Basic include:',
            'options': ['Buttons', 'TextBox', 'Label', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Advantage of Visual Basic:',
            'options': ['Easy drag-drop UI design', 'Rapid development', 'Good for beginners', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u3_1':
      return {
        'content': '''# Basic Programming Principles

## Three Fundamental Control Structures

Every program, no matter how complex, uses these three basic structures:

### 1. Sequencing
- Instructions executed one after another in order
- Top to bottom execution (most basic programming concept)
- Example: Read input, Calculate result, Display output

### 2. Selection (Decision Making)
- IF-THEN-ELSE: Choose path based on condition
- SWITCH statement: Multiple choices (multiple cases)
- Allows different execution paths based on logic

### 3. Iteration (Looping)
- FOR loop: Fixed number of repetitions
- WHILE loop: Repeat while condition is true
- DO-WHILE: Execute at least once, then check condition
- Automates repetitive tasks

## Variables: Named Storage

Variables are named storage locations for data:
- **Declaration**: int x; (reserves memory)
- **Assignment**: x = 10; (stores value)
- **Use**: PRINT x; (retrieves value)

## Data Types

• **Integer**: Whole numbers (-100, 0, 42)
• **Float/Double**: Decimal numbers (3.14, 2.718)
• **String**: Text data ("Hello", "Name")
• **Boolean**: True/False values
• **Character**: Single character ('A', 'x')

## Operators

### Arithmetic Operators
+ (add), - (subtract), * (multiply), / (divide), % (modulo)

### Comparison Operators
== (equal), != (not equal), < (less), > (greater), <= (less/equal), >= (greater/equal)

### Logical Operators
&& (AND): Both conditions true
|| (OR): At least one condition true
! (NOT): Reverses boolean value''',
        'questions': [
          {
            'question': 'Sequencing in programming means:',
            'options': ['Instructions in order', 'One after another', 'Step-by-step execution', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Selection (conditional) includes:',
            'options': ['IF statements', 'SWITCH statements', 'Making decisions based on conditions', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Iteration (loops) includes:',
            'options': ['FOR loops', 'WHILE loops', 'DO-WHILE loops', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'A variable is:',
            'options': ['Named storage location', 'Holds value in memory', 'Has data type', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Data types include:',
            'options': ['Integer', 'Float/Double', 'String', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u3_2':
      return {
        'content': '''# Control Structures & Program Flow

## Understanding Control Flow

Control structures determine which code executes and how many times it runs.

## IF...THEN...ELSE Decisions

The simplest conditional structure:
IF condition THEN
  Execute if true
ELSE
  Execute if false
END IF

## SWITCH Statements

When you have many conditions, SWITCH is cleaner:
SWITCH choice
  CASE 1: PRINT "Option 1"
  CASE 2: PRINT "Option 2"
  CASE 3: PRINT "Option 3"
  DEFAULT: PRINT "Invalid choice"
END SWITCH

## FOR Loops: Fixed Repetition

Repeat code a specific number of times:
FOR i = 1 TO 10
  PRINT i
NEXT i

## WHILE Loops: Conditional Repetition

Repeat code while a condition remains true:
i = 1
WHILE i <= 10
  PRINT i
  i = i + 1
END WHILE

## DO-WHILE Loops: Execute First, Check Later

DO
  INPUT "Enter number (0 to stop): ", num
  PRINT num
LOOP WHILE num != 0

Guarantees at least one execution.

## Nested Loops

Loops inside loops create matrix patterns.

## Logical Operators in Conditions

Combine multiple conditions:
- **AND (&&)**: Both must be true
- **OR (||)**: At least one must be true
- **NOT (!)**: Reverses boolean''',
        'questions': [
          {
            'question': 'Boolean data type:',
            'options': ['Has two values: true/false', 'Used in conditions', 'Occupies 1 byte', 'A and B'],
            'correct': 3,
          },
          {
            'question': 'Operators in programming include:',
            'options': ['Arithmetic (+, -, *, /)', 'Comparison (==, <, >)', 'Logical (AND, OR, NOT)', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'A function is:',
            'options': ['Reusable code block', 'Takes parameters (input)', 'Returns values (output)', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Function parameters are:',
            'options': ['Input values to function', 'Defined in function header', 'Passed during function call', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Return value from function is:',
            'options': ['Output of function', 'Sent back to caller', 'Optional in some functions', 'All of above'],
            'correct': 3,
          },
        ]
      };

    case 'csc102_u3_3':
      return {
        'content': '''# Data Structures & Programming Concepts

## Arrays: Ordered Collections

An array is a collection of elements of the same data type stored in contiguous memory, accessed by index:
Dim scores(5) - Array with 6 elements (0-5)

### Array Advantages
✓ Quick access by index (O(1) time)
✓ Simple and efficient for lists
✓ Used in almost every program

### Array Disadvantages
✗ Fixed size (must know size beforehand)
✗ Expensive insertion/deletion (requires shifting)

## Strings: Special Arrays

A string is a sequence of characters:
Dim name As String = "Nigeria"

Strings have built-in methods:
- .Length: Number of characters
- .ToUpper(): Convert to uppercase
- .ToLower(): Convert to lowercase
- .Substring(): Extract portion

## Dynamic Lists/Collections

Unlike fixed arrays, lists can grow or shrink:
Dim items As New List(Of String)

## Scope: Variable Lifetime

Where a variable is accessible determines its scope:

### Local Scope
Only accessible inside function/block

### Global Scope
Accessible everywhere

### Best Practice: Minimize scope!
- Local variables are safer (no accidental changes)
- Easier to understand and debug
- Less memory used

## Constants: Unchangeable Values

A constant is a variable that cannot be changed after initialization.

### Why Use Constants?
✓ Makes code self-documenting
✓ Prevents accidental changes
✓ Easier to update values (single location)''',
        'questions': [
          {
            'question': 'An array is:',
            'options': ['Collection of elements', 'Same data type', 'Indexed access', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Array index starts at:',
            'options': ['0 (in most languages)', '1 (in some languages)', 'Depends on language', 'Any number'],
            'correct': 2,
          },
          {
            'question': 'A string is:',
            'options': ['Sequence of characters', 'Text data type', 'Immutable in most languages', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'Scope in programming means:',
            'options': ['Where variable is accessible', 'Local vs global scope', 'Lifetime of variable', 'All of above'],
            'correct': 3,
          },
          {
            'question': 'A constant is:',
            'options': ['Value that cannot change', 'Defined at initialization', 'Used for fixed values', 'All of above'],
            'correct': 3,
          },
        ]
      };

    default:
      return {
        'content': 'Lesson not found',
        'questions': []
      };
  }
}