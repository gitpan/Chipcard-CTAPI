use 5.005;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		=> 'Chipcard::CTAPI',
    'VERSION_FROM'	=> 'CTAPI.pm', 
    'PREREQ_PM'		=> {},
    ($] >= 5.005 ?    
      (ABSTRACT_FROM => 'CTAPI.pm', 
       AUTHOR     => 'Wolfgang Hommel <wolf@code-wizards.com>') : ()),
    'LIBS'		=> ['-ltowitoko'], # PUT YOUR CARD TERMINAL CTAPI LIBRARY HERE
    'DEFINE'		=> '', 
    'INC'		=> '-I. -I/client/include', 
	# Un-comment this if you add C files to link with later:
    # 'OBJECT'		=> '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  my @names = (qw(CT CTBCS_CLA CTBCS_DATA_STATUS_CARD
		 CTBCS_DATA_STATUS_CARD_CONNECT CTBCS_DATA_STATUS_NOCARD
		 CTBCS_INS_EJECT CTBCS_INS_REQUEST CTBCS_INS_RESET
		 CTBCS_INS_STATUS CTBCS_MIN_COMMAND_SIZE
		 CTBCS_MIN_RESPONSE_SIZE CTBCS_P1_CT_KERNEL CTBCS_P1_DISPLAY
		 CTBCS_P1_INTERFACE1 CTBCS_P1_INTERFACE10 CTBCS_P1_INTERFACE11
		 CTBCS_P1_INTERFACE12 CTBCS_P1_INTERFACE13 CTBCS_P1_INTERFACE14
		 CTBCS_P1_INTERFACE2 CTBCS_P1_INTERFACE3 CTBCS_P1_INTERFACE4
		 CTBCS_P1_INTERFACE5 CTBCS_P1_INTERFACE6 CTBCS_P1_INTERFACE7
		 CTBCS_P1_INTERFACE8 CTBCS_P1_INTERFACE9 CTBCS_P1_KEYPAD
		 CTBCS_P2_REQUEST_GET_ATR CTBCS_P2_REQUEST_GET_HIST
		 CTBCS_P2_REQUEST_NO_RESP CTBCS_P2_RESET_GET_ATR
		 CTBCS_P2_RESET_GET_HIST CTBCS_P2_RESET_NO_RESP
		 CTBCS_P2_STATUS_ICC CTBCS_P2_STATUS_MANUFACTURER
		 CTBCS_SW1_COMMAND_NOT_ALLOWED CTBCS_SW1_EJECT_NOT_REMOVED
		 CTBCS_SW1_EJECT_OK CTBCS_SW1_EJECT_REMOVED CTBCS_SW1_ICC_ERROR
		 CTBCS_SW1_OK CTBCS_SW1_REQUEST_ASYNC_OK
		 CTBCS_SW1_REQUEST_CARD_PRESENT CTBCS_SW1_REQUEST_ERROR
		 CTBCS_SW1_REQUEST_NO_CARD CTBCS_SW1_REQUEST_SYNC_OK
		 CTBCS_SW1_REQUEST_TIMER_ERROR CTBCS_SW1_RESET_ASYNC_OK
		 CTBCS_SW1_RESET_CT_OK CTBCS_SW1_RESET_ERROR
		 CTBCS_SW1_RESET_SYNC_OK CTBCS_SW1_WRONG_CLA
		 CTBCS_SW1_WRONG_INS CTBCS_SW1_WRONG_LENGTH
		 CTBCS_SW1_WRONG_PARAM CTBCS_SW2_COMMAND_NOT_ALLOWED
		 CTBCS_SW2_EJECT_NOT_REMOVED CTBCS_SW2_EJECT_OK
		 CTBCS_SW2_EJECT_REMOVED CTBCS_SW2_ICC_ERROR CTBCS_SW2_OK
		 CTBCS_SW2_REQUEST_ASYNC_OK CTBCS_SW2_REQUEST_CARD_PRESENT
		 CTBCS_SW2_REQUEST_ERROR CTBCS_SW2_REQUEST_NO_CARD
		 CTBCS_SW2_REQUEST_SYNC_OK CTBCS_SW2_REQUEST_TIMER_ERROR
		 CTBCS_SW2_RESET_ASYNC_OK CTBCS_SW2_RESET_CT_OK
		 CTBCS_SW2_RESET_ERROR CTBCS_SW2_RESET_SYNC_OK
		 CTBCS_SW2_WRONG_CLA CTBCS_SW2_WRONG_INS CTBCS_SW2_WRONG_LENGTH
		 CTBCS_SW2_WRONG_PARAM ERR_CT ERR_HTSI ERR_INVALID ERR_MEMORY
		 ERR_TRANS HOST MAX_APDULEN OK PORT_COM1 PORT_COM2 PORT_COM3
		 PORT_COM4 PORT_LPT1 PORT_LPT2 PORT_Modem PORT_Printer));
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'Chipcard::CTAPI',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
