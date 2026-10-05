# Mountain Peak Analysis: Findings

**Scope:** 20 sales transactions between 2023-01-05 and 2023-06-01, across 10 stores, 16 employees, 11 customers and 16 products. All figures come from the queries in `queries/`.

## 1. Executive summary

- Total sales recorded: **6,529.64** across 20 transactions (average transaction: about 326).
- **Denver is the top store** (1,624.89, about 25% of sales). The West region (Denver, Seattle, Portland) accounts for about 51% of sales.
- **Tents are the top category by revenue** (1,899.94). Tents, Jackets and GPS Devices together make up about 62% of line-item revenue.
- **Water bottles sell the most units (11) but earn little revenue**: volume does not equal value.
- Spending is concentrated: the top 3 customers generate about 44% of sales.
- Four stores (Austin, Nashville, Minneapolis, Empty Store) have no recorded sales, and several records are incomplete (see section 8).

## 2. Setup and method

- Database: PostgreSQL (pgAdmin). Run `setup/create_tables.sql`, then `setup/insert_data.sql`.
- Queries use `LEFT JOIN` where the question asks about every store, customer or employee, so that zero-activity rows are not silently dropped. Inner joins are used where only matched rows make sense.
- Queries that combine several one-to-many relationships (Q18, Q22) aggregate in separate CTEs before joining, to avoid row multiplication.

## 3. Questions 1-5: Basic analysis

Questions 1–5 focused on inventory management and product information within the Mountain Peak Outfitters database.

1. Stock Levels
   The analysis identified products with fewer than 20 items in stock and sorted them by their available quantity. This helps the business identify products that may require restocking.

2. Out-of-Stock Products
   The analysis identified products with a stock quantity of zero. These products are currently unavailable and may require immediate replenishment to avoid potential lost sales.

3. Profit Margins
   The profit margin percentage was calculated for each product using its selling price and cost. The products were then ranked to identify those with the highest profit margins, helping the business understand which products generate better returns.

4. Missing Category or Supplier Information
   The analysis identified products that do not have an assigned category or supplier. Missing relationship data can affect inventory organization, supplier management, and reporting accuracy.

5. Product, Category, and Supplier Relationships
   The analysis combined product information with category and supplier details using SQL JOIN operations. A LEFT JOIN was used so that products without an assigned category or supplier could still be included in the results.

Overall, Questions 1–5 provide an overview of inventory availability, product profitability, data completeness, and relationships between products, categories, and suppliers.


## 4. Sales analysis (Q6-10)

**Q6: Sales by store.** Denver 1,624.89, Seattle 1,384.93, Boston 1,234.92, Chicago 1,054.94, Miami 929.97, Portland 299.99. Austin, Nashville, Minneapolis and Empty Store have no sales. Portland's only sale has no employee attached.

**Q7: Monthly trend.** Jan 1,614.90 (4 transactions), Feb 1,349.93 (4), Mar 759.96 (3), Apr 754.95 (3), May 1,749.91 (5), Jun 299.99 (1). May is the peak month. June looks like a collapse, but the data ends on 1 June, so June is a single day and should not be read as a decline.

**Q8: Revenue by category.** Tents 1,899.94, Jackets 1,059.95, GPS Devices 749.97, Backpacks 549.97, Hiking Boots 459.97, Sleeping Bags 379.97, Water Bottles 334.87, Camp Stoves 299.98, Hiking Poles 239.97. The "Empty Category" has no sales.

**Q9: Top 5 products by units.** EcoTrek Water Bottle (11), Expedition 3-Person Tent (4), then Alpine Waterproof Jacket, TrailSupport Hiking Poles and NavPro GPS Device (3 each).

**Q10: Customer purchase summary.** Alex Roberts has the most purchases (3, latest 2023-06-01). Eight customers have 2 purchases, Charlotte Scott has 1, and "Non-purchasing Customer" has none.

## 5. Customer insights (Q11-15)

**Q11: Spend per customer.** Top spenders: Alex Roberts 1,009.95, Ava King 989.95, Sophia Walker 899.95. The lowest purchasing customer is Matthew Wright at 309.98.

**Q12: Rating by tier.** Gold 3.86 (7 reviews), Silver 4.17 (6), Bronze 3.67 (6), None 4.00 (2). There is no clear link between tier and rating. Gold is pulled down by a 1-star review for a product that does not exist; excluding it lifts Gold to 4.33. With 2-7 reviews per tier, no conclusion is statistically safe.

**Q13: Purchasers with no reviews.** None. Every customer who bought something also left at least one review.

**Q14: Q2 vs Q1 spend.** Four customers spent more in Q2: Charlotte Scott (first purchase in Q2, so up from zero), Emma Young (+125.01), Jacob Allen (+105.00) and Matthew Wright (+50.00). Six purchasing customers spent less. Overall, Q2 sales (2,804.85) are below Q1 (3,724.79), but June is a single day of data, so this comparison is incomplete.

**Q15: Gold-tier favorites.** Tents, Jackets, Hiking Boots and Water Bottles tie at 2 units each. Ranked by revenue, Tents (599.98), Jackets (459.98) and Hiking Boots (309.98) lead.

## 6. Employee performance (Q16-20)

**Q16: Sales by employee.** Top sales associates: Robert Taylor (Seattle, 854.96), Jessica Davis (Denver, 719.95), Laura Jackson (Boston, 679.96), then Michael Brown and Richard Garcia. Managers and assistant managers also sell.

**Q17: Average transaction value.** William White has the highest average (499.99) but from a single sale. Among employees with more than one sale, Robert Taylor leads at 427.48.

**Q18: Store report.** Sales per employee ranges from about 352 (Chicago) to about 465 (Miami). Denver has the most staff (4) and the highest sales. Five stores have no manager or staff on record.

**Q19: Above-average salary stores.** Company average is 52,968.75. Stores above it: Miami 61,500.00, Chicago 54,666.67, Boston 53,833.33, Seattle 53,000.00. Salary does not track sales: Denver has the lowest average salary (50,000.00) and the highest sales, while Miami has the highest average salary on a two-person team (a manager and an assistant manager).

**Q20: Product matrix** (thresholds: average units sold of about 2.7 and average margin of about 57.4%).

| Segment | Products |
|---|---|
| Stars | EcoTrek Water Bottle, Alpine Waterproof Jacket, TrailSupport Hiking Poles |
| Volume Drivers | Expedition 3-Person Tent, NavPro GPS Device |
| Opportunities | Adventure Water Bottle |
| Problems | Nine products, including the boots, backpacks, sleeping bags and Everest Tent |

## 7. Advanced analysis (Q21-22)

**Q21: Hierarchy.** Five stores have a manager with reports. The structure is only two levels deep: sales associates report directly to the store manager, not to the assistant manager.

**Q22: Tier comparison.**

| Tier | Customers | Transactions | Total spend | Avg transaction | Top category | Products reviewed |
|---|---|---|---|---|---|---|
| Gold | 3 | 7 | 2,364.86 | 337.84 | Tents | 5 |
| Silver | 3 | 6 | 2,074.88 | 345.81 | Water Bottles | 5 |
| Bronze | 3 | 6 | 1,689.92 | 281.65 | Water Bottles | 6 |
| None | 2 | 1 | 399.98 | 399.98 | Jackets | 2 |

Gold customers spend the most in total because they transact more often, not because each sale is larger. Silver has the highest average sale among tiers with several transactions. Bronze's lower average reflects heavy purchases of low-priced water bottles.

## 8. Data quality issues

- **Orphan records:** a product with no category or supplier ("Orphan Product"), a sale item with no sale, a review for a non-existent product, an employee with no store, and a sale (store 6) with no employee.
- **Empty parents:** one category, one supplier and one store have no children, and one customer has never purchased.
- **Totals do not reconcile:** `sales.total_amount` sums to 6,529.64, but the line items in `sale_items` support only 5,974.59 of category revenue (about 555 less). Sale-level questions (Q6, Q7, Q11, Q16, Q17, Q18, Q22 spend) use `total_amount`; product- and category-level questions (Q8, Q15, Q20) use line items.
- **Partial period:** data stops on 2023-06-01, so June and Q2 are incomplete.

## 9. Assumptions

- Q12 includes the orphan review (it is tied to a real customer); excluding it changes the Gold average.
- Q14 counts a customer with zero Q1 spend and positive Q2 spend as an increase.
- Q15 defines "favorite" as units purchased, with revenue as the tiebreaker.
- Q19 uses all 16 employees for the company average. Excluding the unassigned employee leaves only Miami and Chicago above average.
- Q20 uses average thresholds and excludes the orphan product, which has no real sales.

## 10. Recommendations

1. **Protect and grow Tents and Jackets.** They are the highest-revenue categories and the core of Gold-tier purchasing.
2. **Push high-margin water bottles.** The Adventure bottle sells little despite a margin near 80%; promote it alongside the best-selling EcoTrek.
3. **Review pricing or costs on Volume Drivers.** The tent and GPS sell well on thinner margins.
4. **Investigate idle stores.** Austin, Nashville and Minneapolis have no sales or staff on record: either data is missing or the stores are not operating.
5. **Fix data capture.** Make `sale_id`, `store_id` and `employee_id` required where appropriate, and reconcile `total_amount` with line items.
6. **Re-run the analysis with a full six months** so June and Q2 comparisons are valid.
