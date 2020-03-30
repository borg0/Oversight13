
// see economy.dm for placement of this. for each payroll, this proc runs to charge the landlord their service charges, and adds to the tenant balance.

/datum/lot/proc/add_balances()

	for(var/datum/tenant/tenant in get_tenants())

		tenant.pay_balance(-get_rent())

		if(landlord)
				// if tenant's balance is below 0, landlord isn't being paid, obviously
			if(get_rent() > tenant.account_balance)
				add_landlord_checkbook("[tenant.name] for [name]: Unable to clear payment. Balance under rent charge.")
			else
				if(landlord)
					landlord.account_balance += get_rent_after_tax()
					var/datum/department/council = dept_by_id(DEPT_COUNCIL)
					council.adjust_funds(get_rent_tax_amount(), "Taxes for [name]")
					add_landlord_checkbook("[tenant.name] for [name]: Payment of [cash2text( get_rent_after_tax(), FALSE, TRUE, TRUE )] successfully paid to landlord account. (After [cash2text( get_rent_tax_amount(), FALSE, TRUE, TRUE )] tax)")


	if(landlord)
		if(get_service_charge() > get_landlord_balance())
			add_landlord_checkbook("[landlord.name] for [name]: Unable to clear payment. Balance under service charge amount.")
			landlord.account_balance -= get_service_charge()
		else

			var/datum/department/council = dept_by_id(DEPT_COUNCIL)
			council.adjust_funds(get_service_charge(), "Service Charge for [name]")
			landlord.pay_balance(-get_service_charge())
			add_landlord_checkbook("Landlord Payment for [name]: [cash2text( get_service_charge(), FALSE, TRUE, TRUE )] successfully paid to City Council.")


/datum/lot/proc/add_landlord_checkbook(info)	// for adding funds to the account
	landlord_checkbook += "([GLOB.current_date_string] [full_game_time()]) [info]"
	truncate_oldest(landlord_checkbook, MAX_LANDLORD_LOGS)


/datum/lot/proc/pay_landlord_balance(amount)	// for adding funds to the account
	landlord.pay_balance(amount)

/datum/lot/proc/pay_tenant_balance(uid, amount)	// for adding funds to the account
	var/datum/tenant/tnt = get_tenant_by_uid(uid)
	tnt.pay_balance(amount)

/datum/lot/proc/send_arrears_letter(uid)	// for adding funds to the account
	var/datum/tenant/resident
	var/type = "TENANT"

	if(get_tenant_by_uid(uid))
		resident = get_tenant_by_uid(uid)
	if(landlord.unique_id == uid)
		resident = landlord
		type = "LEASEHOLDER"

	if(!resident)
		return

	var/severity

	if(resident.account_balance > service_charge_warning)
		severity = "\[b\]WARNING\[/b\]"
	else if(resident.account_balance > service_light_warning)
		severity = "Reminder"


	var/datum/computer_file/data/email_account/council_email = get_email(using_map.council_email)
	var/datum/computer_file/data/email_message/message = new/datum/computer_file/data/email_message()
	var/eml_cnt = "Dear [resident.name], \[br\]Your account balance is currently at [cash2text( resident.get_balance(), FALSE, TRUE, TRUE )]. Severity: [severity].\[br\]"


	if(type == "LEASEHOLDER")
		eml_cnt += "You must bring your bring your account into credit to prevent repossession of your lot. The council may \
		repossess your lot if your balance reaches [cash2text( service_charge_possession, FALSE, TRUE, TRUE )] in debt."

	if(type == "TENANT")
		eml_cnt += "You must bring your bring your account into credit to avoid risking eviction. Your landlord may evict you if your \
		repossession your lot if you remain in debt."

	message.stored_data = eml_cnt
	message.title = "[severity]: [name] Balance Due: [cash2text( resident.get_balance(), FALSE, TRUE, TRUE )]"
	message.source = "noreply@nanotrasen.gov.nt"

	resident.recieved_email = 1
	council_email.send_mail(resident.email, message)
