#define GENERAL_TAX persistent_economy.general_sales_tax
#define BUSINESS_TAX persistent_economy.business_income_tax

#define MEDICAL_TAX persistent_economy.medical_tax
#define WEAPONS_TAX persistent_economy.weapons_tax
#define ALCOHOL_TAX persistent_economy.alcoholic_tax
#define TOBACCO_TAX persistent_economy.tobacco_tax
#define DRUG_TAX persistent_economy.recreational_drug_tax
#define GAMBLING_TAX persistent_economy.gambling_tax
#define HOUSING_TAX persistent_economy.gambling_tax

#define CONTRABAND_CANNABIS persistent_economy.law_CANNABIS
#define CONTRABAND_ALCOHOL persistent_economy.law_ALCOHOL
#define CONTRABAND_ECSTASY persistent_economy.law_ECSTASY
#define CONTRABAND_PSILOCYBIN persistent_economy.law_PSILOCYBIN
#define CONTRABAND_CRACK persistent_economy.law_CRACK
#define CONTRABAND_COCAINE persistent_economy.law_COCAINE
#define CONTRABAND_HEROIN persistent_economy.law_HEROIN
#define CONTRABAND_METH persistent_economy.law_METH
#define CONTRABAND_NICOTINE persistent_economy.law_NICOTINE
#define CONTRABAND_STIMM persistent_economy.law_STIMM
#define CONTRABAND_CYANIDE persistent_economy.law_CYANIDE
#define CONTRABAND_CHLORAL persistent_economy.law_CHLORAL
#define CONTRABAND_DMT persistent_economy.law_DMT
#define CONTRABAND_LSD persistent_economy.law_LSD
#define CONTRABAND_AYAHUASCA persistent_economy.law_AYAHUASCA
#define CONTRABAND_BATHSALTS persistent_economy.law_BATHSALTS
#define CONTRABAND_KROKODIL persistent_economy.law_KROKODIL

#define CONTRABAND_GUN persistent_economy.law_GUNS
#define CONTRABAND_KNIFESMALL persistent_economy.law_SMALLKNIVES
#define CONTRABAND_KNIFELARGE persistent_economy.law_LARGEKNIVES
#define CONTRABAND_EXPLOSIVES persistent_economy.law_EXPLOSIVES

#define FOODSTAMP_MEALS persistent_economy.foodstamp_meals

#define ILLEGAL "Illegal"
#define PROFESSIONAL_ONLY "Professional Use Only"
#define PERMIT_SELLING "Selling permit needed"
#define PERMIT_POSSESSION "Possession and creation permit needed"

#define LEGAL "Legal"

#define NORMAL_TRANSACTION_LIMIT 50
#define DEPARTMENT_TRANSACTION_LIMIT 1000

/proc/get_tax_price(tax, price)
	var/tax_amt
	tax_amt = tax * price
	return price + tax_amt

/proc/get_tax_amount(tax, price)
	var/amt
	amt = tax * price
	return amt


/proc/get_tax_rate(class)

	switch(class)
		if(CLASS_UPPER)
			return persistent_economy.tax_rate_upper * 100
		if(CLASS_MIDDLE)
			return persistent_economy.tax_rate_middle * 100
		if(CLASS_WORKING)
			return persistent_economy.tax_rate_lower * 100

/proc/get_economic_class(money)
	switch(money)
		if(0 to 9999)				return CLASS_WORKING
		if(10000 to 79999)			return CLASS_MIDDLE
		if(80000 to INFINITY)		return CLASS_UPPER

		else 					return CLASS_WORKING	// this accounts for balances that are negative
