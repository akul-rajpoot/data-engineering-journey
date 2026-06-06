

# Data Warehouse Notes

## Fact Table

A Fact Table stores:
- Business events
- Transactions
- Measurable metrics

Examples:
- Sales Amount
- Revenue
- Profit
- Quantity Sold
- Number of Orders

### Example: Fact_Sales

| Order_ID | Customer_ID | Product_ID | Date_ID | Amount |
|-----------|------------|------------|----------|---------|
| 1001 | 101 | 201 | 20250801 | 80000 |
| 1002 | 102 | 202 | 20250802 | 50000 |

### Key Characteristics
- Contains numeric measures
- Contains foreign keys to dimensions
- Usually very large
- Continuously grows

---

## Dimension Table

A Dimension Table stores descriptive information about business entities.

Examples:
- Customer
- Product
- Date
- Store
- Employee
- Region

### Example: Dim_Customer

| Customer_ID | Customer_Name | City |
|------------|--------------|------|
| 101 | Amit | Delhi |
| 102 | Rahul | Mumbai |

### Example: Dim_Product

| Product_ID | Product_Name | Category |
|------------|--------------|----------|
| 201 | iPhone | Mobile |
| 202 | MacBook | Laptop |

### Key Characteristics
- Descriptive attributes
- Smaller than fact tables
- Used for filtering and grouping data

---

## Fact vs Dimension

| Fact Table | Dimension Table |
|------------|------------------|
| Stores metrics | Stores descriptions |
| Contains numbers | Contains attributes |
| Large volume | Smaller volume |
| Example: Revenue | Example: Product Name |
| Example: Quantity Sold | Example: Customer City |

### Memory Trick

Fact = Something happened

Dimension = Tell me about it

---

## Star Schema

A Star Schema consists of:
- One central Fact Table
- Multiple Dimension Tables directly connected to the Fact Table

Example:

```text
           Dim_Customer
                 |
                 |
Dim_Product -- Fact_Sales -- Dim_Date
                 |
                 |
             Dim_Store
```

### Characteristics
- Denormalized dimensions
- Fewer joins
- Faster reporting queries
- Easy to understand
- Uses more storage

---

## Snowflake Schema

A Snowflake Schema is a normalized version of a Star Schema.

Example:

```text
Dim_Category
      |
Dim_Product
      |
Fact_Sales
      |
Dim_Customer
```

### Characteristics
- Normalized dimensions
- More joins
- Less storage
- More complex structure
- Slightly slower reporting queries

---

## Star Schema vs Snowflake Schema

| Feature | Star Schema | Snowflake Schema |
|----------|-------------|------------------|
| Joins | Fewer | More |
| Query Speed | Faster | Slower |
| Storage | More | Less |
| Complexity | Simple | Complex |
| Dimensions | Denormalized | Normalized |

---

## Interview Questions Covered

### Fact or Dimension?

| Item | Answer |
|--------|--------|
| Revenue | Fact |
| Quantity Sold | Fact |
| Number of Orders | Fact |
| Product Name | Dimension |
| Customer City | Dimension |
| Product Category | Dimension |

---

## Quick Revision

### Fact Table
- Stores metrics
- Stores business events
- Large table

### Dimension Table
- Stores descriptive data
- Used for analysis and filtering

### Star Schema
- Denormalized dimensions
- Faster
- Fewer joins

### Snowflake Schema
- Normalized dimensions
- More joins
- Less storage