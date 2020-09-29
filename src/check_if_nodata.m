function [num_of_novalue,novalue_index] = check_if_nodata(crop,nodata_value)
%check_if_nodata ���cropͼ�����Ƿ����nodata_valueֵ�����ش��ڵĸ����Լ�λ��
%   para[in] crop Ӱ���ڴ˾���ָ�ü����ͼ��
%   para[in] nodata_value; ĳ���Ҷ�ֵ��ͨ��ΪNaN��Ŀ���Ǽ�����Ӱ���е�nodata��
%   para[out] num_of_novalue�� nodataֵ�ĸ���
%   para[out] novalue_index�� nodataֵ���ڵ���꣬��find���index
            if isnan(nodata_value)
                novalue_index=find(isnan(crop));
            else
                novalue_index=find(abs(crop-nodata_value)<=2);
            end
            [num_of_novalue,~]=size(novalue_index);
end

