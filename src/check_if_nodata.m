function [num_of_novalue,novalue_index] = check_if_nodata(crop,nodata_value)
%check_if_nodata 检查crop图像中是否存在nodata_value值，返回存在的个数以及位置
%   para[in] crop 影像；在此具体指裁剪后的图像
%   para[in] nodata_value; 某个灰度值；通常为NaN，目的是检索出影像中的nodata。
%   para[out] num_of_novalue： nodata值的个数
%   para[out] novalue_index： nodata值所在的序标，是find后的index
            if isnan(nodata_value)
                novalue_index=find(isnan(crop));
            else
                novalue_index=find(abs(crop-nodata_value)<=2);
            end
            [num_of_novalue,~]=size(novalue_index);
end

