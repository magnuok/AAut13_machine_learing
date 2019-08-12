function [  ] = show_digit(x,i)
digit=x(:,i);
digit=reshape(digit,[5 5]);
disp(digit)
digit=imcomplement(rot90(fliplr(digit)));
disp(digit)
imagesc(digit);axis off
colormap(gray);
end

