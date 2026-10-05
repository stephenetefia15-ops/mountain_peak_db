# Mountain Peak Analysis

SQL analysis of **Mountain Peak**, a fictional outdoor-gear retailer. The project builds a PostgreSQL database (stores, employees, customers, products, sales and reviews) and answers 22 business questions about sales, customers, employee performance and product mix.

## Project overview

The database models a retail chain with:

- **10 stores** across four regions, with employees arranged in a manager hierarchy
- **16 products** in 10 categories from 10 suppliers
- **11 customers** in loyalty tiers (Gold, Silver, Bronze, None)
- **20 sales** (January to June 2023), their line items, and 21 product reviews

The sample data includes deliberate edge cases: records with no parent (orphans), parents with no children (an empty store, category, supplier and customer), and a sale with no employee. The queries are written to handle these correctly.

## Repository structure

```
mountain-peak-analysis/
├── README.md                     # Project overview and instructions
├── setup/
│   ├── create_tables.sql         # Database schema creation script
│   └── insert_data.sql           # Sample data insertion script
├── queries/
│   ├── basic_analysis.sql        # Solutions for questions 1-5
│   ├── aggregation_analysis.sql  # Solutions for questions 6-10
│   ├── relationship_analysis.sql # Solutions for questions 11-15
│   ├── advanced_analysis.sql     # Solutions for questions 16-20
│   └── complex_analysis.sql      # Solutions for questions 21-22
└── reports/
    └── findings.md               # Text summary of all findings
```

## Requirements

- PostgreSQL 12 or later (the queries use `FILTER`, `DISTINCT ON` and recursive CTEs)
- pgAdmin 4, or the `psql` command-line client

## How to run

### Option A: pgAdmin

1. Create a new database, e.g. `mountain_peak`.
2. Open the **Query Tool** on that database.
3. Open `setup/create_tables.sql` and run it (F5).
4. Open `setup/insert_data.sql` and run it. **Run the scripts in this order**, because the foreign keys need the parent tables first.
5. Verify the load: `SELECT COUNT(*) FROM sales;` should return **20**.
6. Open any file in `queries/` and run the queries one at a time. Select a single query before pressing F5, because pgAdmin runs only the highlighted text.

### Option B: psql

```bash
createdb mountain_peak
psql -d mountain_peak -f setup/create_tables.sql
psql -d mountain_peak -f setup/insert_data.sql
psql -d mountain_peak -f queries/aggregation_analysis.sql
```

## Query guide

| File | Questions | Topics |
|---|---|---|
| `basic_analysis.sql` | 1-5 | Basic retrieval and filtering |
| `aggregation_analysis.sql` | 6-10 | Sales by store and month, category revenue, top products, customer purchase summary |
| `relationship_analysis.sql` | 11-15 | Customer spend, ratings by loyalty tier, unreviewed purchasers, Q1 vs Q2 spend, Gold-tier favorites |
| `advanced_analysis.sql` | 16-20 | Employee sales, average transaction value, store report, salary comparison, product performance matrix |
| `complex_analysis.sql` | 21-22 | Recursive management hierarchy, loyalty-tier customer analysis |

Each query is preceded by a comment stating the question it answers.

## Design notes

- **Joins:** `LEFT JOIN` is used when a question covers every store, customer or employee, so that zero-activity rows still appear. Inner joins are used when only matched rows make sense.
- **Avoiding double counting:** queries that combine several one-to-many relationships (Q18, Q22) aggregate each side in its own CTE before joining.
- **Dates:** filters use `>=` and `<` ranges rather than functions on the column.
- **Anti-joins:** `NOT EXISTS` is used instead of `NOT IN`, which misbehaves when the subquery contains `NULL`.

## Known data quirks

- `sales.total_amount` (6,529.64 in total) does not equal the sum of its line items in `sale_items`. Store, month, customer and employee questions use `total_amount`; product and category questions use line items.
- Sales end on 2023-06-01, so June and Q2 are incomplete.
- Orphan records exist: a product with no category or supplier, a sale item with no sale, a review for a non-existent product, an employee with no store, and a sale with no employee.

## Results

See [`reports/findings.md`](reports/findings.md) for the summary of findings, assumptions and recommendations.
