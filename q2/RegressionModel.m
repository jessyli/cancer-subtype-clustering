function [loss] = RegressionModel(data,labels,mode)
% Implements a regression model
% Inputs: data - a 1000 by 25 matrix containing the data from 1000 patients.
%         labels - a 1 by 1000 vector containting the survival times for the patients
%         mode - a flag that determines which batch selection strategy is used. 1 = default selection mode; 2 = diverse label mode
% Outputs: loss a 1 by 90 vector that returns the generalization error as function of the number of rounds (90) 
load fisheriris

loss = zeros(1,90);
rng(1); % For reproducibility
data1 = data([1:20],:);
label1 = labels(1:20);
datatest = [];
labeltest=[];
datatest = [datatest, data1];
labeltest = [labeltest, label1];

datanew = data([21:1000],:);

predictlabel = zeros(1,1000);
predictlabel(1:20) = labels(1:20);
if mode == 1
    for i = 1:90
        BaggedEnsemble = TreeBagger(50,datatest,labeltest,'OOBPred','On');
        
        
        
        [Y] = predict(BaggedEnsemble,datanew);
        Y1=cellfun(@str2num,Y);
        labelnew = Y1';
        
        [C,IA,IB] = intersect(data,datanew,'rows');      
        predictlabel(IA)=labelnew(IB);
        X = predictlabel;
        y = labels;
        

        

        cvMse = sqrt (mean ((X - y).^2));
        loss(i)=cvMse;
        error = abs(labelnew-Y1');
        [b, c] = sort(error,2);
        index1 = c(1);
        index2 = c(2);
        datatest = [datatest; datanew(index1,:)];
        datatest = [datatest; datanew(index2,:)];
        labeltest = [labeltest, labelnew(index1)];
        labeltest = [labeltest, labelnew(index2)];
        datanew(index1,:) = [];
        datanew(index2,:) = [];
        labelnew(index1)=[];
        labelnew(index2)=[];
        
        
        
        
        
    end
else 
    for i = 1:90
        BaggedEnsemble = TreeBagger(50,datatest,labeltest,'OOBPred','On');
        
        [Y] = predict(BaggedEnsemble,datanew);
        
        Y1=cellfun(@str2num,Y);
        labelnew = Y1';
        [C,IA,IB] = intersect(data,datanew,'rows');      
        predictlabel(IA)=labelnew(IB);
        X = predictlabel;
        y = labels;
        

        

        cvMse = sqrt (mean ((X - y).^2));
        loss(i)=cvMse;
        error = abs(labelnew-Y1');
%         error = cellfun(@minus,labelnew,Y,'UniformOutput',false);
        error = abs(labelnew-Y1');
        [b, c] = sort(error,2);
        len = length(c);
        len1 = len*0.33;
        len2 = len*0.66;
        index1 = c(floor(len1));
        index2 = c(ceil(len2));
        datatest = [datatest; datanew(index1,:)];
        datatest = [datatest; datanew(index2,:)];
        labeltest = [labeltest, labelnew(index1)];
        labeltest = [labeltest, labelnew(index2)];
        datanew(index1,:) = [];
        datanew(index2,:) = [];
        labelnew(index1)=[];
        labelnew(index2)=[];
%         oobErrorBaggedEnsemble = oobError(BaggedEnsemble);
%         loss(i)=oobErrorBaggedEnsemble;
    end
    
end
end
