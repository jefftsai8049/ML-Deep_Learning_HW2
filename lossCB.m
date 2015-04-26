function delta = lossCB(param, y, ybar)
  delta = sum(~isequal(y,ybar))/size(y,1);
  
  
%   %N=frames,ybar=probability(framesx48)
%   delta=0;
%   N = size(y,1); %sequenceLength
%   for i=1:N
%     for j=1:48
%         %{
%         version-1
%         if(ybar(i,j)~=0)
%         delta=delta+log2(ybar(i,j));            %But w is randomly initialized?
%         end
%         %}
%     end
%         %{
%         version-2
%         delta=delta+log2(i,ybar(y(i)+1));       %Only computing correct y
%         %}
%   end
%   delta=-1/N*delta;
  
  
  if param.verbose
    fprintf('delta = loss(%3d, %3d) = %f\n', y, ybar, delta) ;
  end
end