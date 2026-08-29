# Online Retail Performance Analysis

## Executive Summary

Using **MySQL and Power BI**, I analyzed 2010–2011 retail transactions to identify the main revenue drivers and cancellation risks. Despite ~2K fewer orders, revenue increased by **~$0.1M**, while cancellation impact nearly doubled to **~$458K**. I recommend focusing on increasing order value in the UK market and investigating recurring cancellation patterns at the product level.

1. Investigate the drivers of higher UK AOV
2. Review high-frequency cancellation products
3. Monitor high-value cancellation transactions

## Business Problem

The business needs to understand **what drives revenue performance and where sales are being lost through cancellations**. Revenue increased in 2011 despite fewer orders, while cancellation impact increased significantly. **How can we identify the key revenue drivers and the cancellation patterns that require business attention?**

## Methodology

Used **MySQL** for data cleaning, validation, and business analysis, followed by **Power BI** for data modeling, DAX calculations, KPI analysis, and interactive visualization.

**Key analysis:**

* Revenue & Order Trends
* AOV Analysis
* Product Performance
* UK vs Non-UK Performance
* Customer Analysis
* Cancellation Analysis

## Key Findings

* **Revenue:** ~$9.4M → ~$9.5M despite ~2K fewer orders.
* **UK AOV:** ~$444 → ~$488, helping offset lower order volume.
* **Cancellations:** ~$238.5K → ~$458.4K impact.
* **High-frequency risk:** One product had **167 cancelled orders from 108 customers**.
* **High-value risk:** A single December cancellation had an impact of approximately **-$168K**.

## Recommendations

1. **Investigate UK AOV growth** to identify whether product mix, quantity per order, or customer behavior drove the increase.
2. **Investigate the product with 167 cancellations** to identify potential recurring product or order issues.
3. **Monitor high-value cancellations separately from cancellation frequency**, since both represent different types of business risk.

## Tools & Skills

**MySQL • SQL • Power BI • Power Query • DAX • Data Cleaning • Data Modeling • EDA • Business Analysis**

---
