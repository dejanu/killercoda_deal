## Probes and RestartPolicy

Avoid using `AWK`, `grep` to customize the output of `kubectl`.
The default output format for all kubectl commands is the human readable plain-text format.

To output details to your terminal window in a specific format, you can add either the `-o` or `--output` flags to a supported kubectl command: `kubectl [command] [TYPE] [NAME] -o <output_format>`

Get only the pods name from `kube-system` and write them to `controlplane.txt`

<details>
<summary>⚠️ Solution</summary>
Get name: <code>kubectl -n kube-system get po -oname</code>
<br>
Get table with custom columns: <code>kubectl -n kube-system get po -o=custom-columns=NAME:.metadata.name</code>
<br>
Get table with custom columns: <code>kubectl -n kube-system get pods -o custom-columns=:metadata.name</code>
<br>
Get using go template:<code>kubectl get po -A -o go-template='{{range .items}} --> {{.metadata.name}} in namespace: {{.metadata.namespace}}{{"\n"}}{{end}}'</code>
</details>

