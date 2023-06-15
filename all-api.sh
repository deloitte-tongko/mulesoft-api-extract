ALL_API=(api-payment-v1 api-police-check-v1 api-police-report-v1 api-product-v1 api-product-v2 api-solar-installation-v1 batch-customer-v1 batch-delegation-v1 batch-environment-planning-v1 batch-identity-verification-v1 batch-miners-rights-v1 batch-ndis-v1 batch-notification-v1 batch-payment-v1 batch-police-check-v1 batch-user-v1 batch-wwcc-v1 sys-dwrs-proxy-v1 sys-sales-force-proxy-01 sys-wwcc-proxy-01);

if [[ -d output/ && -f output/output.csv ]]; then
	rm output/output.csv;
fi

for API in ${ALL_API[@]}; do
	. main.sh $API;
done
