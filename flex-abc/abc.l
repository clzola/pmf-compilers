%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


%}

%%
[\t\n ]					;
^a([abc][abc])*b$		{ printf("YES\n"); }
^a([abc][abc])*c$		{ printf("YES\n"); }
^b([abc][abc])*a$		{ printf("YES\n"); }
^b([abc][abc])*c$		{ printf("YES\n"); }
^c([abc][abc])*a$		{ printf("YES\n"); }
^c([abc][abc])*b$		{ printf("YES\n"); }
[abc]+					{ printf("NO\n");  }
[^abc]+  				{ printf("NO\n");  }
.						;
%%


