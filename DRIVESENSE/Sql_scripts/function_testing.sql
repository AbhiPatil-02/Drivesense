--function testing 
--1. Test Function: GetMostReplacedPart()
SELECT GetMostReplacedPart('KA05MN1234') AS Most_Replaced_Part;

--exptectd output:
/*
Most_Replaced_Part
-------------------
Brake Pad
*/

/* ---Explanation:---

The function:
Joins all parts replaced for KA05MN1234
Counts how many times each part appeared in PART_REPLACEMENT
Returns the one with the highest count (here Brake Pad)

---Real-world meaning:---
“The brake pads for this Hyundai i20 are replaced more frequently than any other part — they may need frequent attention.”

*/

-------------------------------------------------------------------------------------------------------------   
--2. Test Function: GetAvgReplacementDays()
SELECT GetAvgReplacementDays('KA05MN1234', 'Brake Pad') AS Avg_Days_Between_Replacements;

--Expected Result:
/*
Avg_Days_Between_Replacements
------------------------------
153
*/
/* ---Explanation:---
The function:
Finds min and max service dates for that part (Brake Pad)
Uses DATEDIFF(MAX, MIN) to compute average interval
Returns how many days apart replacements typically occur

Real-world meaning:
“Brake pads on this vehicle last about 150 days between services.”
*/

