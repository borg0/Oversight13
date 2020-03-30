/datum/expense
  var/name = "Generic Expense"
  var/cost_per_payroll = 1          // per payroll
  var/department = DEPT_COUNCIL
  var/purpose = "Bill"

  var/charge_department			// if specified, this is the department that will be charged instead of an account.

  var/comments                      // comments on this particular case.

  var/initial_cost				//how much it cost in the beginning

  var/amount_left

  var/active = TRUE		               // If this is currently active, or not.

  var/delete_paid = TRUE				// does this expense delete itself when paid?
  var/direct_debit = 0				// does this ever deplete? or does it keep topping itself up?

  var/applied_by					// ckey of the person who made this expense
  var/added_by						// IC version of the person who made this.

  var/creation_date					// Date of when this was made.

  var/color = COLOR_WHITE			// the color this is associated with. usually for departments

  var/list/ckey_edit_list					// ckey of last editor(s)

  var/can_remove = TRUE

/datum/expense/proc/do_effect()	// this is actually does something, it'll trigger here.
	return


// This proc takes payment and then returns the "change"
/datum/expense/proc/process_charge(var/num)
	if(!active)
		return 0

	var/charge

	if(num > amount_left)
		charge += amount_left
	else
		charge += num

	if(direct_debit)
		amount_left += direct_debit

	amount_left -= charge

	if(department)
		adjust_dept_funds(department, charge)

	return charge

// This proc is just a default proc for paying expenses per payroll.

/datum/expense/proc/payroll_expense(var/datum/money_account/bank_account)
	charge_expense(src, bank_account, cost_per_payroll)

// If you want to charge a department.

/datum/expense/proc/charge_department(num)
	if(!charge_department || !department) return

	var/negative = FALSE

	if(0 > num)
		negative = TRUE

	//the department getting charged.
	var/datum/money_account/bank_acc = dept_acc_by_id(charge_department)
	// department recieving the money.
	var/datum/money_account/dept_bank_acc = dept_acc_by_id(department)

	if(!bank_acc || !dept_bank_acc) return

	if(negative)
		charge_expense(src, bank_acc, num)
		charge_expense(src, dept_bank_acc, -num)
	else
		charge_expense(src, bank_acc, -num)
		charge_expense(src, dept_bank_acc, num)

	return TRUE


//This if for if you have a expense, and a bank account.

/proc/charge_expense(var/datum/expense/E, var/datum/money_account/bank_account, var/num)
	if(!E.is_active())
		return 0

	E.process_charge(num)
	bank_account.money -= num

	bank_account.add_transaction_log(bank_account.owner_name, "Debt Payment: [E.name]", -num, "[E.department] Funding Account")

	E.do_effect()

	if(E.delete_paid && !E.amount_left)
		bank_account.expenses -= E
		qdel(E)

/datum/expense/proc/is_active()
	return active

/datum/expense/police
	name = "Police Fine"
	cost_per_payroll = 30
	var/datum/law/fine

	department = DEPT_POLICE

	color = COLOR_RED_GRAY


/datum/expense/hospital
	name = "Hospital Bill"
	cost_per_payroll = 30
	var/datum/medical_bill

	department = DEPT_HEALTHCARE

	color = COLOR_BLUE_GRAY


/datum/expense/law
	name = "Court Injunction"
	cost_per_payroll = 50

	department = DEPT_LEGAL

	color = COLOR_OLIVE

// This proc is just a default proc for paying expenses per payroll.

/proc/create_expense(var/expense_type, var/name, var/comments, var/amount_left, var/added_by, var/applied_by)
	var/datum/expense/new_expense = new expense_type(src)

	new_expense.name = name
	new_expense.comments = comments
	new_expense.amount_left = amount_left
	new_expense.initial_cost = amount_left
	new_expense.added_by = added_by
	new_expense.applied_by = applied_by

	new_expense.creation_date = "[get_game_day()] [get_month_from_num(get_game_month())], [get_game_year()] - [stationtime2text()]"

	return new_expense
