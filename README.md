# Online Retail Performance Analysis
**Understanding Revenue, Sales & Cancellation Risk (2010–2011)**

## Executive Summary

Using MySQL and Power BI, I analyzed 2010–2011 online retail transactions to identify the main revenue drivers and cancellation risks. Despite roughly 2,000 fewer orders in 2011, revenue increased by £0.1M, while the financial impact of cancellations nearly doubled to £458.4K. I recommend investigating what drove the UK's higher average order value, auditing the product responsible for high-frequency repeat cancellations, and tracking high-value single-order cancellations separately from recurring ones, since they represent different types of business risk.

**Top 3 priorities:**
1. Investigate what is driving higher UK average order value (AOV)
2. Audit the product with high-frequency, multi-customer cancellations
3. Track high-value single-order cancellations separately from recurring cancellation patterns

---

## Business Problem

The business needs to understand what is driving revenue performance and where sales value is being lost through order cancellations. Revenue increased in 2011 despite fewer total orders, while the value lost to cancellations grew significantly year-over-year. This analysis answers two questions:

1. What actually drove the revenue increase, given that order volume fell?
2. What is driving the sharp rise in cancellation impact, and is it a recurring risk or a one-off event?

---

## Methodology

- **MySQL**: data cleaning, validation, and initial business analysis (handling nulls, duplicate checks, cancellation flagging, aggregate validation).
- **Power BI**: data modeling, DAX measures, KPI cards, and interactive visualization with slicers for Month, Year, and Transaction Type (Sale / Cancellation).

**Key analysis areas:**
- Revenue & order trends (2010 vs 2011)
- Average order value (AOV) analysis, UK vs Non-UK
- Product-level performance (top revenue, top cancellations)
- Market performance (UK vs Non-UK, by quarter)
- Customer-level cancellation concentration
- Cancellation analysis: frequency vs. value

---
## Tools & Skills

MySQL · Window_Functions ·Power BI · Power Query · DAX · Data Cleaning · Exploratory Data Analysis · Business Analysis---

---
## Key Findings

| Metric | 2010 | 2011 | Change |
|---|---|---|---|
| Sales revenue (excl. cancellations) | £9.4M | £9.5M | +£0.1M |
| Total orders | ~20K | ~18K | -2K |
| Cancellation impact | -£238.5K | -£458.4K | +£219.9K (~92%) |
| UK AOV | £444 | £488 | +£44 |
| Non-UK AOV | £888 | £825 | -£63 |

**1. Revenue grew despite fewer orders — driven by UK's rising AOV.**
UK accounts for the large majority of order volume and leads revenue in every quarter of 2011 (e.g. £2,772K vs £407K in Q4 alone). Because UK carries most of the order volume, its AOV increase (£444 → £488) outweighed both the drop in total order count and the AOV decline in the smaller Non-UK segment (£888 → £825).

**2. Two products account for a disproportionate share of cancellation value.**
Products `23843` and `22423` — coincidentally also two of the top 5 revenue-generating products in 2011 — drove the majority of the year's cancellation impact. One single order for product `23843` (~80,995 units) accounted for approximately -£168K in December alone.

**3. A separate, high-frequency cancellation pattern exists independent of order value.**
One product recorded 167 cancelled orders from 108 distinct customers, indicating a recurring issue (e.g. product quality, mislabeling, or fulfillment error) rather than a single anomalous transaction.

**4. High-value risk and high-frequency risk are different problems.**
The -£168K December cancellation is a concentrated, single-customer, single-order event. The 167-order/108-customer pattern is a distributed, systemic issue. Treating both as "cancellations" without distinguishing them would point the business toward the wrong fix.

---

## Recommendations

1. **Test whether the UK's AOV increase is broad-based or driven by a small number of large orders.** If it's concentrated in a few big-basket customers, it isn't a repeatable growth lever; if it's broad-based, it's worth reinforcing through UK-focused upsell or bundling strategies.
2. **Audit the product with 167 cancellations across 108 customers for a root cause** (defect, incorrect listing, sizing/fit issue, fulfillment error) rather than treating it as routine returns — the customer spread suggests a product-level issue, not buyer-specific behavior.
3. **Separate high-value and high-frequency cancellations in ongoing reporting.** A single £168K cancellation and a 167-order recurring pattern require different owners and different fixes; combining them into one "cancellation rate" metric would mask both.
4. **Quantify recoverable revenue.** If the recurring-cancellation product issue is fixed, estimate the potential reduction in 2012 cancellation impact as a percentage of the £458.4K total, to give the business a concrete target.

---

## Repo Structure

```
├── README.md
├── images/
│   ├── dashboard_sales_view.png
│   └── dashboard_cancellation_view.png
├── sql/
│   └── data_cleaning_and_validation.sql
├── powerbi/
│   └── online_retail_dashboard.pbix
└── data/
    └── online_retail.csv   (or link to UCI source if too large to host)
```

## Author

*Menna_Tarek*
