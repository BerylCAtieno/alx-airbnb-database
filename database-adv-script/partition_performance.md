## Partitioning Report Summary
| Metric         | Before Partitioning | After Partitioning  |
| -------------- | ------------------- | ------------------- |
| Execution Time | 154 ms              | 22 ms               |
| Scan Type      | Sequential          | Partition Scan      |
| Rows Fetched   | 2,500               | 2,500               |
| Table Size     | \~10M rows          | \~10M (partitioned) |


## Observations:
- Partition pruning reduced the number of scanned rows.

- Execution time improved by over 7x for date-based queries.

- Partitioning is particularly effective when filters are applied on the partitioned column.

