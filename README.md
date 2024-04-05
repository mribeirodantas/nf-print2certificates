## Run the pipeline
You can run a demo with the following command:
```
nextflow run mribeirodantas/nf-print2certificates -r main
```

If you want to provide custom names, templates and fonts you can run with:
```
nextflow run main.nf --names names.txt --template CertificateAttendance.png --font GochiHand-Regular.ttf
```

## Check the results
Check the `output` folder in the current working directory to find the certificates
