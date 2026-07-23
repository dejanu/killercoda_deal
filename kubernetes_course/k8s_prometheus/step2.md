
### TSDB

* Restart the Prometheus pod: `kubectl  delete po -l app=prometheus`

* Prometheus TSDB lives on the container's ephemeral filesystem in **data** dir: `kubectl exec -it prometheus-767cfdcb8b-rgjtg -- sh`

```
ls -ltr /prometheus/data
total 28
drwxr-xr-x    2 nobody   nobody        4096 Jul 23 20:03 wal
-rw-r--r--    1 nobody   nobody           0 Jul 23 20:03 lock
drwxr-xr-x    2 nobody   nobody        4096 Jul 23 20:03 chunks_head
-rw-r--r--    1 nobody   nobody       20001 Jul 23 20:12 queries.active
```

Ingested data is grouped into blocks, and each 2-hour block consists of a directory that contains a chunks subdirectory and an index file. The current block for incoming samples is kept in memory and not fully persisted and it's secured against crashes by WAL (write-ahead log)

* wal/ — Write-Ahead Log. Recent samples not yet compacted into blocks; used for crash recovery.
* chunks_head/ — In-memory head block's on-disk chunks (recent data, not yet flushed to a persisted block).
* queries.active — Tracks currently-running queries (for crash debugging), not metric data.
* lock — Lock file preventing multiple Prometheus processes from using the same data dir simultaneously