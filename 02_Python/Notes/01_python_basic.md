# Python Day 1: Basics (Beginner Friendly)

---

## 🧠 What is Python?

Python is a high-level, easy-to-read programming language used in:
- Data Engineering
- Data Science
- Web Development
- Automation

Python focuses on **readability and simplicity**, making it ideal for beginners.

---

## 🎯 Goal of Day 1

By the end of this file, you should understand:
- Variables
- Data Types
- Lists
- Dictionaries
- Loops
- Conditions
- Functions

---

# 🔹 1. Variables

A variable is used to store data.

```python
# assigning values
a = 10
b = 20

print(a)
print(b)
print(a + b)
```

👉 Python does NOT require type declaration.

---

# 🔹 2. Data Types

```python
x = 10          # int (integer)
y = 10.5        # float (decimal)
name = "Amit"   # string (text)
flag = True     # boolean (True/False)

print(type(x))
print(type(y))
print(type(name))
print(type(flag))
```

---

# 🔹 3. List

A list stores multiple values in a single variable.

```python
nums = [10, 20, 30, 40]

print(nums)
print(nums[0])     # first element
print(nums[-1])    # last element

nums.append(50)   # add element
print(nums)
```

---

## 🔸 Common List Operations

```python
print(len(nums))
print(sum(nums))
print(max(nums))
print(min(nums))
```

---

# 🔹 4. Dictionary

A dictionary stores data in key-value pairs.

```python
emp = {
    "name": "Amit",
    "salary": 50000,
    "city": "Delhi"
}

print(emp["name"])
print(emp["salary"])
```

---

## 🔸 Loop Through Dictionary

```python
for key, value in emp.items():
    print(key, value)
```

---

# 🔹 5. Loops

Loops are used to repeat code.

```python
for i in range(1, 6):
    print(i)
```

---

## 🔸 Loop Through List

```python
nums = [10, 20, 30]

for num in nums:
    print(num * 2)
```

---

# 🔹 6. Conditions

Used to make decisions.

```python
x = 10

if x > 5:
    print("Greater")
else:
    print("Smaller")
```

---

# 🔹 7. Functions

Functions help reuse code.

```python
def add(a, b):
    return a + b

print(add(2, 3))
```

---

## 🔸 Example Function

```python
def is_even(n):
    return n % 2 == 0

print(is_even(4))  # True
print(is_even(5))  # False
```

---

# 🔥 Practice Problems (Must Do)

```python
nums = [10, 15, 20, 25, 30]

# 1. Print only even numbers
# 2. Find total sum using loop (not sum())
# 3. Find max number manually
# 4. Create new list with each element multiplied by 2
```

---

# 🔹 8. List Comprehension

## 📌 What is List Comprehension?

List comprehension is a concise way to create lists in Python using a single line of code.
It replaces traditional loops with cleaner and more readable syntax.

## 🧠 Basic Syntax

```python
[expression for item in iterable]
```

## Example
```python 
nums = [1, 2, 3, 4]
result = []
for num in nums:
    result.append(num * 2)

#list comprehension
result = [num * 2 for num in nums]
```

## 🟡 With Condition (Filtering)
```python 
nums = [10, 15, 20, 25, 30]
evens = [num for num in nums if num % 2 == 0]
```
## 🧠 Key Concepts

* for → iteration
* if → filtering
* if-else → conditional transformation
* expression → what to store in list

# 🧠 Important Rules

- Do not overwrite built-in functions like `sum`, `max`
- Always think about edge cases
- Keep code simple and readable
- For list comprehension Order matters [expression for item in list if condition]


---

# 🚀 What’s Next?

In Day 2, you will learn:
- List Comprehension
- Better Python style
- More problem-solving

---

# 🎯 Summary

- Python is simple and readable
- Variables store data
- Lists store multiple values
- Dictionaries store key-value pairs
- Loops repeat tasks
- Conditions control flow
- Functions reuse code

---
