** 2: regress income on all explanatory variables
reg income province gender age married edu ethnicity hhsize dep_ratio urban log_aland log_pland log_fland log_gland year

** residual - versus - fitted plot
rvfplot

** 2: test for heteroskedasticity
estat hettest 

** 2: test for multicollinearity
vif

**2: test for normality 
predict r, resid 
histogram r, normal

** 2: if heteroskedasticity 
gen log_income = ln(income+1)
reg log_income province gender age married edu ethnicity hhsize dep_ratio urban log_aland log_pland log_fland log_gland year, robust

** 3: different income in 4 group 
reg log_income i.urban#i.gender province age married edu ethnicity hhsize dep_ratio log_aland log_pland log_fland log_gland year, robust
outreg2 using log_income.doc
marginsplot, title("Different Effects on Income Across Household Groups") ytitle("Linear prediction") xtitle("years of schooling of the household head") legend(label(1 "urban=0, gender=0") label(2 "urban=0, gender=1") label(3 "urban=1, gender=0") label(4 "urban=1, gender=1"))

** 3: province
reg log_income i.province gender age married edu ethnicity hhsize dep_ratio urban log_aland log_pland log_fland log_gland year, robust
margins province
marginsplot, title("Income Differences Across Provinces") ytitle("Log_Income (Predicted)", size(medium)) xlabel(, labsize(vsmall) angle(45) grid) legend(off) plotopts(lwidth(medium) msymbol(circle)) b1title("Provinces")
outreg2 using province.doc

** 3: between 2016 and 2018
reg log_income i.year province gender age married edu ethnicity hhsize dep_ratio urban log_aland log_pland log_fland log_gland, robust
reg log_income i.year2018
margins year2018
marginsplot, title("Income Differences Between 2016 and 2018") ytitle("Log-Income (Predicted)")xtitle("1=2018; 0=2016") xlabel(0 "2016" 1 "2018")
outreg2 using regression_results.doc, replace label se ctitle("(1) Regression Results") bdec(3) rdec(3) addstat("Observations", e(N), "R-squared", e(r2))

** 4: the effect edu on income between kinh and ethnicity minority households
reg log_income c.edu##i.ethnicity urban province gender age married hhsize dep_ratio log_aland log_pland log_fland log_gland year, robust
margin ethnicity, dydx(edu)
marginsplot, title("Impact of Education on Income by Ethnicity") ytitle("Linear prediction") xtitle("years of schooling of the household head") legend(label(1 "ethnicity=0") label(2 "ethnicity=1")) ylabel(6.5(0.5)8.5) xlabel(1(1)20)

** 4: test 17% higher
ttest year==0.17

** 5: draw graph
reg log_income c.edu##i.ethnicity urban province gender age married hhsize dep_ratio log_aland log_pland log_fland log_gland year, robust
margins ethnicity, at(edu=(0(1)22)) atmeans vsquish
marginsplot




