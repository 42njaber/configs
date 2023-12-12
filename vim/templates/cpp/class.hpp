
#ifndef  [:VIM_EVAL:]"__" . toupper(substitute(expand("%:t:r"),"\\.","_","g")) . "_H__"[:END_EVAL:]
# define [:VIM_EVAL:]"__" . toupper(substitute(expand("%:t:r"),"\\.","_","g")) . "_H__"[:END_EVAL:]

class [:VIM_EVAL:]expand('%:t:r:r')[:END_EVAL:] {

public:

	/** *structors **/
	[:VIM_EVAL:]expand('%:t:r:r')[:END_EVAL:]( void );
	~[:VIM_EVAL:]expand('%:t:r:r')[:END_EVAL:]( void );

	/** Getters **/
	/** Setters **/

	/** Others **/

private:

};

#endif
