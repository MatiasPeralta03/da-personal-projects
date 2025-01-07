# Coffee Sales Analysis and Dashboard
## Project Description
This project analyzes coffee sales data using Excel as the main tool. It started with a dataset inspired by a guided project by Mo Chen, but I customized and enhanced it to explore the data in unique ways and create a functional dashboard.

## Objective
The primary goals of this analysis were to:

- Clean and transform the initial data.
- Fill in missing information using advanced formulas like XLOOKUP, INDEX, and MATCH.
- Generate insights through pivot tables and visualizations.
- Create a dashboard showcasing key performance indicators (KPIs) and trends.
  
## Steps Taken
1. Data Preparation
Datasets: The project began with three sheets: Products, Customers, and Sales.
Working Copies: I created working copies of the sheets to avoid altering the original data.
Merging Data:
For customer information (e.g., Customer Name, Email, Country, Loyalty Card), I used XLOOKUP.
For product details (e.g., Coffee Type, Roast Type, Size, Unit Price), I applied a combination of INDEX and MATCH to populate multiple columns at once.

2. Data Transformation
Sales Value: A basic multiplication formula was used to calculate the sales value for each transaction.
Expanded Descriptions:
Nested IF formulas expanded simplified codes (e.g., Exc for Excelsa, D-M-L for roast types).
Custom formatting added units like kg to the Size column (e.g., converting 1 to 1.0 kg or 2.5 to 2.5 kg).
Duplicate Check: Verified and confirmed no duplicates in the dataset.

3. Analysis Sheet
Created an Analysis sheet to build multiple pivot tables and visualizations, including:
Sales Growth: Displayed percentage growth by year with conditional formatting.
KPIs: Total revenue, total quantity sold, unique customers, and average order value.
Coffee Types: Quantities and percentages for each type of coffee sold.

4. Dashboard Creation
Developed a dashboard to present the following key insights:
Sales by Country: A breakdown of total sales by region.
Total Sales Performance (2019-2022): Included revenue trends with a trendline.
Coffee Sales Overview: Displayed quantities and percentages for each coffee type.
KPIs: Highlighted total revenue, average order value, and unique customers.
Filters: Added slicers for Loyalty Card, Roast Type, and Size.

## Highlights
Customization: While inspired by a guided project, I applied unique approaches to the dataset and created personalized formulas and visualizations.
Growth Analysis: Though the growth column was not directly used in the dashboard, it provides additional insights in the analysis sheet.

## Tools Used
Excel Features: XLOOKUP, INDEX-MATCH, nested IFs, pivot tables, conditional formatting, and slicers.
Results
The final dashboard effectively showcases key metrics and trends, enabling data-driven decision-making for coffee sales performance analysis.


