
%Replace these paths with location of your copy of the Glasser2016 parcels
L_parcelCIFTIFile='~/ParcelsGlasser2016/Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.dlabel.nii';
R_parcelCIFTIFile='~/ParcelsGlasser2016/Q1-Q6_RelatedParcellation210.R.CorticalAreas_dil_Colors.32k_fs_LR.dlabel.nii';

L_parcelTSFilename='Output_Atlas.L.Parcels.32k_fs_LR.ptseries.nii';
R_parcelTSFilename='Output_Atlas.R.Parcels.32k_fs_LR.ptseries.nii';

inputFile='Run1_fMRIData_Atlas.dtseries.nii';

eval(['!wb_command -cifti-parcellate ' inputFile ' ' L_parcelCIFTIFile ' COLUMN ' L_parcelTSFilename ' -method MEAN'])
eval(['!wb_command -cifti-parcellate ' inputFile ' ' R_parcelCIFTIFile ' COLUMN ' R_parcelTSFilename ' -method MEAN'])

%Load parcellated data (requires the ciftiopen function from the HCP website, FieldTrip)
L_dat = ciftiopen(L_parcelTSFilename,'wb_command');
R_dat = ciftiopen(R_parcelTSFilename,'wb_command');

NUMPARCELS=360;
tseriesMatSubj=zeros(NUMPARCELS,size(L_dat.cdata,2));
tseriesMatSubj(1:180,:)=L_dat.cdata);
tseriesMatSubj(181:end,:)=R_dat.cdata);