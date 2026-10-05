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


## Q21
The hierarchy is only two levels deep. Sales associates report directly to the store manager, 
not to the assistant manager, because the UPDATE statements in the data set it up that way.
Portland, Austin, Nashville, Minneapolis and Empty Store have no managers, so they don't appear.
The "Orphan Employee" has no store and no manager, so they're left out too.


## Q22
1) Gold customers spend the most in total, but not per transaction. They have more transactions (7), 
while Silver has the higher average transaction value (345.81). Bronze is lowest at 281.65.

2) Silver and Bronze buy mostly water bottles. This is a low-priced, high-volume item, which 
explains Bronze's lower average sale.

3) Gold has a four-way tie on units (Tents, Jackets, Hiking Boots and Water Bottles at 2 each). 
Tents wins on revenue, so say that tiebreaker out loud in your report.

4) "None" is one customer's single sale. Jackets and Camp Stoves tie at 1 unit, and Jackets wins 
on revenue. Treat that row as an anecdote, not a pattern.

5) Review activity doesn't track tier. Bronze reviewed the most distinct products (6), 
and Gold and Silver reviewed 5 each. This fits Q12 finding that tier doesn't clearly 
predict behaviour.
