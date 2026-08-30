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
UK carries most of the order volume and leads revenue in every quarter of 2011 (e.g. £2,772K vs £407K in Q4). Its AOV increase (£444 → £488) outweighed both the drop in total orders and Non-UK's AOV decline (£888 → £825).

**2. Two products account for most of the cancellation value.**
`23843` and `22423` — also two of the top 5 revenue products in 2011 — drove most of the year's cancellation impact. A single order for `23843` (~80,995 units) accounted for ~£168K of that, in December alone.

**3. A separate, high-frequency cancellation pattern exists independent of order value.**
One product had 167 cancelled orders across 108 different customers — a spread that wide points to a recurring product issue, not a one-off.

**4. High-value risk and high-frequency risk are different problems.**
The £168K cancellation is one customer, one order. The 167-order pattern is spread across 108 customers. Same word ("cancellation"), two different root causes — and two different fixes.

**5. There's a clear seasonal sales pattern: Aug–Nov peak, November highest, in both years.**
Six products rank in the top 10 by revenue in both 2010 and 2011 (`22086`, `85123A`, `22423`, `22910`, `85099B`, `22197`). One new product launched in 2011, `23084`, immediately became the top seller in Q4 (487 orders, 325 customers) — out of 639 new products introduced that year.

**6. UK's AOV advantage holds even at the quarter level.**
In Q4, UK AOV rose £497 → £519 while Non-UK fell £860 → £637 — the same pattern seen in the full-year numbers, which makes it more likely to be a real, repeatable shift rather than noise.

**7. Customer loyalty dropped in 2011, alongside the rise in cancellations.**
Loyalty fell most sharply in December (37.55% → 21.17%), the same period cancellations nearly doubled year-over-year. The two moving together doesn't prove cancellations caused the drop — but it's worth testing directly.

**8. December 2011 orders fell sharply even though AOV rose.**
Orders dropped 2,000 → 816 (~59%), and revenue fell £775.7K → £614.5K — a smaller decline than the order drop alone would suggest, because UK AOV rose £490 → £600 in the same month. November's cancellations were checked and ruled out as the cause. The real driver is still unknown.

---

## Recommendations

1.Prepare inventory before Q4

Increase stock coverage for historically high-demand products before August, with additional monitoring during October–November.

2. Monitor new-product performance

Create an early-warning system for newly introduced products that rapidly gain customers, orders, or revenue so inventory can be scaled quickly.

3. Strengthen UK customer strategy

The UK remains the core market and shows increasing AOV. Focus retention and promotional strategies on high-value UK customers.

4. Investigate cancellation-driven customer loss

The sharp increase in cancellations alongside declining loyalty warrants a review of order accuracy, product quality, fulfillment, and customer complaints.


Open Questions / Further Investigation
December 2011 order drop: Orders fell sharply (2,000 → 816, ~59%) despite a higher UK AOV (£490 → £600), resulting in a smaller but still notable revenue decline (£775.7K → £614.5K). November cancellations were checked and ruled out as insufficient to explain the drop. The cause is not yet identified — competitor pricing/promotions and broader market conditions are untested hypotheses that would require external data to confirm.

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
