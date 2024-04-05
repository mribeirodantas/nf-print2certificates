## Build the container image
docker build -t print_to_certs .

## Run the pipeline
nextflow run main.nf --names names.txt --template CertificateAttendance.png --font GochiHand-Regular.ttf

## Check the results
Check the `output` folder in the current working directory to find the certificates
