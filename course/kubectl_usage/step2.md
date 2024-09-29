## Output

Avoid using `AWK`, `grep` to customize the output of `kubectl`.
The default output format for all kubectl commands is the human readable plain-text format.

To output details to your terminal window in a specific format, you can add either the `-o` or `--output` flags to a supported kubectl command: `kubectl [command] [TYPE] [NAME] -o <output_format>`

Get only the pod name from `kube-system` and write them to `controlplane.txt`

<details>
<summary>Solution</summary>
Get name: `kubectl -n kube-system get po -oname`{{copy}}
Get table with custom columns: `kubectl -n kube-system get po -o=custom-columns=NAME:.metadata.name`{{copy}}
Get table with custom columns:  `kubectl -n kube-system get pods -o custom-columns=:metadata.name`{{copy}}
Get using go template:`kubectl -n kube-system po -o go-template='{{range .items}} --> {{.metadata.name}} in namespace: {{.metadata.namespace}}{{"\n"}}{{end}}`{{copy}}
</details>

