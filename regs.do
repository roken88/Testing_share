clear all

use nrfpanel

set matsize 11000

xtset id rryear

gen subject=0 
replace subject=1 if discipline=="chemistry"
replace subject=2 if discipline=="physics"
replace subject=3 if discipline=="materials science"
replace subject=4 if discipline=="engineering"
replace subject=5 if discipline=="computer science"
replace subject=6 if discipline=="geoscience"

egen yrsb=group(apply subject), label

drop if complete==0

drop if announce==2014

drop if year==2015

gen male=gender=="male"

gen yrsincephd=year-phd_grad

gen loghi=log(hi)
gen logpb=log(pb)
gen logct=log(ct)

set more off
fvset base 13 rryear
est clear

//+ sig. if 3 batches for hi pb ct, - sig. if more bathes

eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using 1.xls,append dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
outreg2 using 1.xls,replace dec(3) adjr2 label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


set more off
fvset base 13 rryear
est clear
//+ sig. 1.nrf#16.rryear 1.nrf#17.rryear 1.nrf#18.rryear pb-4,5,6

eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using 2.xls,replace dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
outreg2 using 2.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


set more off
fvset base 13 rryear
est clear

eststo hi_fe_log1: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using 3.xls,replace dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_fe_log2: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo hi_fe_log3: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)
                                                                                                                                                                                                                                                                                                            
eststo pb_fe_log1: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_fe_log2: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo pb_fe_log3: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)
                                                                                                                                        
eststo ct_fe_log1: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=16 & announce<=2011, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_fe_log2: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=17 & announce<=2010, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

eststo ct_fe_log3: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id)
outreg2 using 3.xls,append dec(3) label sortvar (*.nrf* *.rryear*) drop(0b.nrf* group* *.subject* male* arwu_phd* arwu_insapp*)

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps




set more off
fvset base 13 rryear
est clear

quietly{
eststo nrf_1: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2011, cl(id)
eststo nrf_2: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2010, cl(id)
eststo nrf_3: probit nrf c.pb##i.rryear c.ct##i.rryear i.subject yrsincephd male i.arwu_phd i.arwu_insapp if rryear>=12 & rryear<=13 & announce<=2009, cl(id)

}
esttab nrf_* , se star(* 0.1 ** 0.05 *** 0.01) nogaps




set more off
fvset base 13 rryear
est clear


//+ sig. 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_4: reg hi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_4: reg pb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_4: reg ct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#18.rryear pb-6
quietly{
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_4: xtreg hi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
          
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_4: xtreg pb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
     
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_4: xtreg ct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#17.rryear 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log4: reg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
              
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log4: reg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
            
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log4: reg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//+ sig. 1.nrf#17.rryear 1.nrf#18.rryear pb-6
quietly{
eststo hi_ols_log1: xtreg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_ols_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_ols_log4: xtreg loghi i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                   
eststo pb_ols_log1: xtreg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_ols_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_ols_log4: xtreg logpb i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                 
eststo ct_ols_log1: xtreg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_ols_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_ols_log4: xtreg logct i.nrf##i.rryear i.yrsb i.subject#c.yrsincephd i.subject#i.year i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)

}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


















/* 11-11 */
//negative sig. for hi, ct post interactions, positive sig. 1.nrf(pb-6)!!!!!
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_2: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_2: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_2: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}
esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//negative sig. for hi, ct post interactions, positive sig. 1.nrf(pb-6)!!!!!
quietly {
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo hi_re_2: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
               
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo pb_re_2: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
               
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo ct_re_2: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

//positive sig. 1.nrf#17.rryear, pb,<=2010
quietly {
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
                  
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
                  
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps


//positive sig. 1.nrf#16.rryear 1.nrf#17.rryear, pb,<=2010
quietly {
eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                  
eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
                  
eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=16 & announce<=2011, re cl(id)
eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=17 & announce<=2010, re cl(id)
eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.male *.arwu_* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps



/*

//post interact nonsig. except 1.nrf#14.rryear 1.nrf(pb-6)!!!!! 1.nrf (all ct)
quietly{
eststo hi_ols_1: reg hi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_2: reg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_3: reg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo pb_ols_1: reg pb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_2: reg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_3: reg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)

eststo ct_ols_1: reg ct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_2: reg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_3: reg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

//post interact nonsig. except 1.nrf#14.rryear 1.nrf(pb-6)!!!!! 1.nrf (all ct)
quietly{
eststo hi_re_1: xtreg hi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_2: xtreg hi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_3: xtreg hi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
          
eststo pb_re_1: xtreg pb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_2: xtreg pb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_3: xtreg pb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
    
eststo ct_re_1: xtreg ct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_2: xtreg ct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_3: xtreg ct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

//post interact nonsig.
quietly{
eststo hi_ols_log1: reg loghi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log2: reg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo hi_ols_log3: reg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
             
eststo pb_ols_log1: reg logpb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log2: reg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo pb_ols_log3: reg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
           
eststo ct_ols_log1: reg logct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log2: reg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
eststo ct_ols_log3: reg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
}

//post interact nonsig.
quietly{
eststo hi_re_log1: xtreg loghi i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_log2: xtreg loghi i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo hi_re_log3: xtreg loghi i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
             
eststo pb_re_log1: xtreg logpb i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_log2: xtreg logpb i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo pb_re_log3: xtreg logpb i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
           
eststo ct_re_log1: xtreg logct i.nrf##i.rryear i.subject if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_log2: xtreg logct i.nrf##i.rryear i.yrsb if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
eststo ct_re_log3: xtreg logct i.nrf##i.rryear i.yrsb yrsincephd i.male i.arwu_phd i.arwu_insapp if rryear>=10 & rryear<=18 & announce<=2009, re cl(id)
}

esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb) order(*.nrf* *.rryear*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

*/








//probit nrf pb i.yrsb i.arwu_phd i.arwu_insapp male yrsincephd if year==apply & announce<=2009, vce(robust)




/*11-06*/
set more off
fvset base 13 rryear
est clear

quietly {
//eststo hi_fe: xtreg hi i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo hi_ols2009: reg hi i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg hi i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo hi_ols2009_2: reg hi i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo hi_ols2009_3: reg hi i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)

//eststo pb_fe: xtreg pb i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo pb_ols2009: reg pb i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg pb i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo pb_ols2009_2: reg pb i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo pb_ols2009_3: reg pb i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)



//eststo ct_fe: xtreg ct i.nrf##ib13.rryear if rryear>=10 & rryear<=18 & announce<=2009, fe cl(id) 
eststo ct_ols2009: reg ct i.yrsb i.nrf##i.rryear if rryear>=10 & rryear<=18 & announce<=2009, cl(id)
//eststo ols2011: reg ct i.yrsb i.nrf i.nrf#i.rryear i.rryear if rryear>=10 & rryear<=16 & announce<=2011, cl(id)
eststo ct_ols2009_2: reg ct i.yrsb i.nrf##i.rryear i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)
//eststo ct_ols2009_2: reg ct i.yrsb i.nrf##i.rryear##i.subject i.subject##i.yrsincephd if rryear>=10 & rryear<=18 & announce<=2009 & yrsincephd>=0, cl(id)

}
esttab hi_* pb_* ct_*, drop(0.nrf* *.yrsb *.subject* *.yrs*) se star(* 0.1 ** 0.05 *** 0.01) nogaps

