This is executable java jar file which includes source java files also. To execute this jar file use java higher than 1.7 version. This jar file includes code for paper identifying emerging influential nodes in evovling networks: Exploiting strenght of hte weak nodes. This file includes the source .java files only for develeped code. It can be found in com package.

This is script for running the executable jar. Command line arguments are as follows-
-fname : fileFullPath 
-mi : model Index (0 for PBP,  4 for page rank,5 for proposed model, 6 for Indegree)
-smi : sub model index (M1:1,M2:2,M3:3) this is only in case of our proposed models.
-st : Start time value
-et : end time value.
-out : out put directory name. 
-itp: when Tp is varying it should be 1 other wise 0.
-itf: when Tf is varying  it should be 1 other wise 0. at a time only one from -itp or -itf should be one.
-mp0,mp1,mp2: model parameter 0,1 and two. mp0 is for the models where only one parameter like PBP and PageRank. -mp1 is for decay rate gamma in M1,M2 and M3. And -mp2 is for delta in our proposed model.  
file should be in the format of : fromNode toNode time : all values in integer should be preferred.

Proposed M1 (When TF and TP both are varying) -M1 ....Running
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 5 -st 1 -et 200 -itf 0 -itp 1 -out M1 -mp0 0.9  -mp1 0.01 -smi 1

Proposed M2 (When TF and TP both are varying) -M2 ...Running
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 5 -st 1 -et 200 -itf 0 -itp 1 -out M2 -mp0 0.9  -mp1 0.01 -smi 2

Proposed M3 (When TF and TP both are varying) -M3 ...Running
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 5 -st 1 -et 200 -itf 0 -itp 1 -out M3 -mp0 0.9  -mp1 0.01 -smi 3 -mp2 0.9

PageRank-(When TF and TP both are varying)
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 4 -st 1 -et 200 -itf 0 -itp 1 -out PR -mp0 0.9  -mp1 0.01 
 
PageRank-(When TF is varying but TP is varying)
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 4 -st 1 -et 200 -itf 1 -itp 0 -out PR -mp0 0.9   
 
Indegree
java -jar identifyingEmergingInfluentialNodes.jar -fname ../../data/data.txt  -mi 6 -st 0 -et 200 -itf 0 -itp 1 -out IND  


Result file structure
The out put file contains following structure
Tp		 Tf		AUC50	 AUC100	  AUC200 zero P50(Precion) P100      P200	 Q50	 Q100   Q200     Tq50	 Tq100	 Tq200   -		-
30.0	 30.0	 0.752	 0.739	 0.727	 0	 0.098	 		0.15	 0.217	 0.072	 0.09	 0.136	 0.084	 0.097	 0.146	 -1.0	 0.0

Tp: Past time window lenght
Tf: Future time window lenght
AUC50,P100 and Q50 are same refer to the manuscript evaluation metric. Tq100 is for temporal novelty not used in this paper. Which tells accuracy about predicting those nodes which were not top popular list in past time window. 
