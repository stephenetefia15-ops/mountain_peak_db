## Sales Analysis

Q6 and Q7 use sales.total_amount, which adds up to 6529.64. Q8 uses sale_items, 
whose categories add up to 5974.59. The two don't match because the header totals 
in sales don't equal the sum of their line items (e.g. sale 1 has items 
totalling 364.97 but a total_amount of 479.97).

## Q13: Customers with purchases but no product reviews
this returns zero rows, and that's correct. Customers 1-10 all bought something and 
all left at least one review. Customer 11 never bought anything, so they're correctly excluded.

## Q20: Product performance matrix (sales volume vs. profit margin)
the two water bottles are very high margin, so the cheaper Adventure bottle is the obvious 
product to push. The tent and GPS sell well but at thinner margins, 
so they're candidates for a price or cost review.
