#include <UNIX64/cinterface>
extern TLint4	TL_TLI_TLIARC;

extern void TL_TLI_TLIFA ();

extern void TL_TLX_TLXGE ();

extern void TL_TLX_TLXDT ();

extern void TL_TLX_TLXTM ();

extern void TL_TLX_TLXCL ();

extern void TL_TLX_TLXSC ();

extern void time ();

extern void TL_TLX_TLXSYS ();

extern TLint4 getpid ();

extern void TL_TLI_TLIFS ();

extern void TL_TLK_TLKUEXIT ();
extern TLnat4	TL_TLK_TLKTIME;
extern TLnat4	TL_TLK_TLKEPOCH;

extern void TL_TLK_TLKUDMPA ();

extern void TL_TLK_TLKCINI ();
extern TLboolean	TL_TLK_TLKCLKON;
extern TLnat4	TL_TLK_TLKHZ;
extern TLnat4	TL_TLK_TLKCRESO;
extern TLnat4	TL_TLK_TLKTIME;
extern TLnat4	TL_TLK_TLKEPOCH;

extern void TL_TLK_TLKPSID ();

extern TLnat4 TL_TLK_TLKPGID ();

extern void TL_TLK_TLKRSETP ();

static void encode (line, __x45)
TLstring	line;
TLstring	__x45;
{
    TLstring	eline;
    TLSTRASS(4095, eline, "");
    {
	register TLint4	i;
	TLint4	__x81;
	__x81 = TL_TLS_TLSLEN(line);
	i = 1;
	if (i <= __x81) {
	    for(;;) {
		{
		    TLchar	__x82[2];
		    TL_TLS_TLSBX(__x82, (TLint4) i, line);
		    switch (((TLnat4) TLCVTTOCHR(__x82))) {
			case 60:
			    {
				TLSTRCATASS(eline, "&lt;", 4095);
			    }
			    break;
			case 62:
			    {
				TLSTRCATASS(eline, "&gt;", 4095);
			    }
			    break;
			case 38:
			    {
				TLSTRCATASS(eline, "&amp;", 4095);
			    }
			    break;
			default :
			    {
				{
				    TLchar	__x83[2];
				    TL_TLS_TLSBX(__x83, (TLint4) i, line);
				    TLSTRCATASS(eline, __x83, 4095);
				};
			    }
			    break;
		    };
		};
		if (i == __x81) break;
		i++;
	    }
	};
    };
    {
	TLSTRASS(4095, __x45, eline);
	return;
    };
    /* NOTREACHED */
}
static TLstring	ccfile;
static TLint4	ccf;
static TLstring	rccfile;
static TLint4	rccf;
static TLstring	line;
static TLstring	systemname;
static TLstring	granularity;
static TLstring	threshold;
static TLstring	minlines;
static TLstring	maxlines;
static TLstring	npcs;
static TLstring	npairs;
static TLstring	ncompares;
static TLstring	cputime;
static TLint4	cputotalms;
static TLint4	cpums;
static TLint4	cpusec;
static TLint4	cpumin;
void TProg () {
    {
	TLstring	__x85;
	{
	    TLstring	__x84;
	    TL_TLI_TLIFA((TLint4) 1, __x84);
	    if ((strcmp(__x84, "") == 0) || ((TL_TLI_TLIFA((TLint4) 2, __x85), strcmp(__x85, "") == 0))) {
		TL_TLI_TLISS ((TLint4) 0, (TLint2) 2);
		TL_TLI_TLIPS ((TLint4) 0, "Usage:  tothml.x system_functions-clonepairs-withsource.xml system_functions-clonepairs-withsource.html", (TLint2) 0);
		TL_TLI_TLIPK ((TLint2) 0);
		TL_TLE_TLEQUIT ((TLint4) 1, (char *) 0, 0);
	    };
	};
    };
    {
	TLstring	__x86;
	TL_TLI_TLIFA((TLint4) 1, __x86);
	TLSTRASS(4095, ccfile, __x86);
    };
    TL_TLI_TLIOF ((TLnat2) 2, ccfile, &ccf);
    if (ccf == 0) {
	TL_TLI_TLISS ((TLint4) 0, (TLint2) 2);
	TL_TLI_TLIPS ((TLint4) 0, "*** Error: can\'t open sourced clone classes input file", (TLint2) 0);
	TL_TLI_TLIPK ((TLint2) 0);
	TL_TLE_TLEQUIT ((TLint4) 1, (char *) 0, 0);
    };
    {
	TLstring	__x87;
	TL_TLI_TLIFA((TLint4) 2, __x87);
	TLSTRASS(4095, rccfile, __x87);
    };
    TL_TLI_TLIOF ((TLnat2) 4, rccfile, &rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<html>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<head>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<style type=\"text/css\">", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "body {font-family:Arial}", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "table {background-color:white; border:0px solid white; width:95%; margin-left:auto; margin-right: auto}", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "td {background-color:#b0c4de; padding:16px; border:4px solid white}", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "pre {background-color:white; padding:4px}", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</style>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<title>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "NiCad Clone Report", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</title>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</head>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<body>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<h2>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "NiCad Clone Report", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</h2>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
    TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
    if (strcmp(line, "<clones>") != 0) {
	TL_TLI_TLISS ((TLint4) 0, (TLint2) 2);
	TL_TLI_TLIPS ((TLint4) 0, "*** Error: malformed sourced clone classes input file", (TLint2) 0);
	TL_TLI_TLIPK ((TLint2) 0);
	TL_TLE_TLEQUIT ((TLint4) 1, (char *) 0, 0);
    };
    TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
    TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
    {
	TLstring	__x88;
	TL_TLS_TLSBXX(__x88, (TLint4) (TL_TLS_TLSIND(line, "\" granularity=") - 1), (TLint4) (TL_TLS_TLSIND(line, "system=\"") + TL_TLS_TLSLEN("system=\"")), line);
	TLSTRASS(4095, systemname, __x88);
    };
    {
	TLstring	__x89;
	TL_TLS_TLSBXX(__x89, (TLint4) (TL_TLS_TLSIND(line, "\" threshold=") - 1), (TLint4) (TL_TLS_TLSIND(line, "granularity=\"") + TL_TLS_TLSLEN("granularity=\"")), line);
	TLSTRASS(4095, granularity, __x89);
    };
    {
	TLstring	__x90;
	TL_TLS_TLSBXX(__x90, (TLint4) (TL_TLS_TLSIND(line, "\" minlines=") - 1), (TLint4) (TL_TLS_TLSIND(line, "threshold=\"") + TL_TLS_TLSLEN("threshold=\"")), line);
	TLSTRASS(4095, threshold, __x90);
    };
    {
	TLstring	__x91;
	TL_TLS_TLSBXX(__x91, (TLint4) (TL_TLS_TLSIND(line, "\" maxlines=") - 1), (TLint4) (TL_TLS_TLSIND(line, "minlines=\"") + TL_TLS_TLSLEN("minlines=\"")), line);
	TLSTRASS(4095, minlines, __x91);
    };
    {
	TLstring	__x92;
	TL_TLS_TLSBXX(__x92, (TLint4) (TL_TLS_TLSIND(line, "\"/>") - 1), (TLint4) (TL_TLS_TLSIND(line, "maxlines=\"") + TL_TLS_TLSLEN("maxlines=\"")), line);
	TLSTRASS(4095, maxlines, __x92);
    };
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "System: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, systemname, (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>Granularity: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, granularity, (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>Max difference threshold: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, threshold, (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>Clone size: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, minlines, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, " - ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, maxlines, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, " lines", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
    TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
    {
	TLstring	__x93;
	TL_TLS_TLSBXX(__x93, (TLint4) (TL_TLS_TLSIND(line, "\" npairs=") - 1), (TLint4) (TL_TLS_TLSIND(line, "npcs=\"") + TL_TLS_TLSLEN("npcs=\"")), line);
	TLSTRASS(4095, npcs, __x93);
    };
    {
	TLstring	__x94;
	TL_TLS_TLSBXX(__x94, (TLint4) (TL_TLS_TLSIND(line, "\"/>") - 1), (TLint4) (TL_TLS_TLSIND(line, "npairs=\"") + TL_TLS_TLSLEN("npairs=\"")), line);
	TLSTRASS(4095, npairs, __x94);
    };
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>Total ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, granularity, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, ": ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, npcs, (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>Clone pairs found: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, npairs, (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
    TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
    {
	TLstring	__x95;
	TL_TLS_TLSBXX(__x95, (TLint4) (TL_TLS_TLSIND(line, "\" cputime=") - 1), (TLint4) (TL_TLS_TLSIND(line, "ncompares=\"") + TL_TLS_TLSLEN("ncompares=\"")), line);
	TLSTRASS(4095, ncompares, __x95);
    };
    {
	TLstring	__x96;
	TL_TLS_TLSBXX(__x96, (TLint4) (TL_TLS_TLSIND(line, "\"/>") - 1), (TLint4) (TL_TLS_TLSIND(line, "cputime=\"") + TL_TLS_TLSLEN("cputime=\"")), line);
	TLSTRASS(4095, cputime, __x96);
    };
    cputotalms = TL_TLS_TLSVSI(cputime, (TLint4) 10) / 1000;
    cpums = cputotalms % 1000;
    cpusec = (cpums / 1000) % 60;
    cpumin = (cpums / 1000) / 60;
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>LCS compares: ", (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, ncompares, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, " &nbsp;&nbsp;&nbsp; CPU time: ", (TLint2) rccf);
    TL_TLI_TLIPI ((TLint4) 0, (TLint4) cpumin, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, " min ", (TLint2) rccf);
    TL_TLI_TLIPI ((TLint4) 0, (TLint4) cpusec, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, ".", (TLint2) rccf);
    TL_TLI_TLIPI ((TLint4) 0, (TLint4) cpums, (TLint2) rccf);
    TL_TLI_TLIPS ((TLint4) 0, " sec", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "<br>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    for(;;) {
	if (TL_TLI_TLIEOF((TLint4) ccf)) {
	    break;
	};
	TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
	TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
	if (TL_TLS_TLSIND(line, "<classinfo ") == 1) {
	    TLstring	nclasses;
	    {
		TLstring	__x97;
		TL_TLS_TLSBXX(__x97, (TLint4) (TL_TLS_TLSIND(line, "\"/>") - 1), (TLint4) (TL_TLS_TLSIND(line, "nclasses=\"") + TL_TLS_TLSLEN("nclasses=\"")), line);
		TLSTRASS(4095, nclasses, __x97);
	    };
	    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
	    TL_TLI_TLIPS ((TLint4) 0, "<br>Number of  classes: ", (TLint2) rccf);
	    TL_TLI_TLIPS ((TLint4) 0, nclasses, (TLint2) rccf);
	    TL_TLI_TLIPK ((TLint2) rccf);
	    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
	    TL_TLI_TLIPS ((TLint4) 0, "<br>", (TLint2) rccf);
	    TL_TLI_TLIPK ((TLint2) rccf);
	} else {
	    if ((TL_TLS_TLSIND(line, "<clone ") == 1) || (TL_TLS_TLSIND(line, "<class ") == 1)) {
		if (TL_TLS_TLSIND(line, "<clone ") == 1) {
		    TLstring	pairlines;
		    TLstring	similarity;
		    {
			TLstring	__x98;
			TL_TLS_TLSBXX(__x98, (TLint4) (TL_TLS_TLSIND(line, "\" similarity=") - 1), (TLint4) (TL_TLS_TLSIND(line, "nlines=\"") + TL_TLS_TLSLEN("nlines=\"")), line);
			TLSTRASS(4095, pairlines, __x98);
		    };
		    {
			TLstring	__x99;
			TL_TLS_TLSBXX(__x99, (TLint4) (TL_TLS_TLSIND(line, "\">") - 1), (TLint4) (TL_TLS_TLSIND(line, "similarity=\"") + TL_TLS_TLSLEN("similarity=\"")), line);
			TLSTRASS(4095, similarity, __x99);
		    };
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "<h3>", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "Clone pair, nominal size ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, pairlines, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, " lines, similarity ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, similarity, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, "%", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "</h3>", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "<table cellpadding=12 border=2 frame=\"box\" width=\"90%\">", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		} else {
		    TLstring	classid;
		    TLstring	nclassclones;
		    TLstring	classlines;
		    TLstring	similarity;
		    {
			TLstring	__x100;
			TL_TLS_TLSBXX(__x100, (TLint4) (TL_TLS_TLSIND(line, "\" nclones=") - 1), (TLint4) (TL_TLS_TLSIND(line, "classid=\"") + TL_TLS_TLSLEN("classid=\"")), line);
			TLSTRASS(4095, classid, __x100);
		    };
		    {
			TLstring	__x101;
			TL_TLS_TLSBXX(__x101, (TLint4) (TL_TLS_TLSIND(line, "\" nlines=") - 1), (TLint4) (TL_TLS_TLSIND(line, "nclones=\"") + TL_TLS_TLSLEN("nclones=\"")), line);
			TLSTRASS(4095, nclassclones, __x101);
		    };
		    {
			TLstring	__x102;
			TL_TLS_TLSBXX(__x102, (TLint4) (TL_TLS_TLSIND(line, "\" similarity=") - 1), (TLint4) (TL_TLS_TLSIND(line, "nlines=\"") + TL_TLS_TLSLEN("nlines=\"")), line);
			TLSTRASS(4095, classlines, __x102);
		    };
		    {
			TLstring	__x103;
			TL_TLS_TLSBXX(__x103, (TLint4) (TL_TLS_TLSIND(line, "\">") - 1), (TLint4) (TL_TLS_TLSIND(line, "similarity=\"") + TL_TLS_TLSLEN("similarity=\"")), line);
			TLSTRASS(4095, similarity, __x103);
		    };
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "<h3>Clone class ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, classid, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, ", ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, nclassclones, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, " fragments, nominal size ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, classlines, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, " lines, similarity ", (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, similarity, (TLint2) rccf);
		    TL_TLI_TLIPS ((TLint4) 0, "%", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "</h3>", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "<table cellpadding=12 border=2 frame=\"box\" width=\"90%\">", (TLint2) rccf);
		    TL_TLI_TLIPK ((TLint2) rccf);
		};
		for(;;) {
		    if (TL_TLI_TLIEOF((TLint4) ccf)) {
			break;
		    };
		    TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
		    TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
		    if ((strcmp(line, "</clone>") == 0) || (strcmp(line, "</class>") == 0)) {
			break;
		    };
		    if (TL_TLS_TLSIND(line, "<source") == 1) {
			TLstring	srcfile;
			TLstring	startline;
			TLstring	endline;
			TLstring	pcid;
			{
			    TLstring	__x104;
			    TL_TLS_TLSBXX(__x104, (TLint4) (TL_TLS_TLSIND(line, "\" startline=") - 1), (TLint4) (TL_TLS_TLSIND(line, "file=\"") + TL_TLS_TLSLEN("file=\"")), line);
			    TLSTRASS(4095, srcfile, __x104);
			};
			{
			    TLstring	__x105;
			    TL_TLS_TLSBXX(__x105, (TLint4) (TL_TLS_TLSIND(line, "\" endline=") - 1), (TLint4) (TL_TLS_TLSIND(line, "startline=\"") + TL_TLS_TLSLEN("startline=\"")), line);
			    TLSTRASS(4095, startline, __x105);
			};
			{
			    TLstring	__x106;
			    TL_TLS_TLSBXX(__x106, (TLint4) (TL_TLS_TLSIND(line, "\" pcid=") - 1), (TLint4) (TL_TLS_TLSIND(line, "endline=\"") + TL_TLS_TLSLEN("endline=\"")), line);
			    TLSTRASS(4095, endline, __x106);
			};
			{
			    TLstring	__x107;
			    TL_TLS_TLSBXX(__x107, (TLint4) (TL_TLS_TLSIND(line, "\">") - 1), (TLint4) (TL_TLS_TLSIND(line, "pcid=\"") + TL_TLS_TLSLEN("pcid=\"")), line);
			    TLSTRASS(4095, pcid, __x107);
			};
			TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "<tr><td>", (TLint2) rccf);
			TL_TLI_TLIPK ((TLint2) rccf);
			TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "Lines ", (TLint2) rccf);
			TL_TLI_TLIPS ((TLint4) 0, startline, (TLint2) rccf);
			TL_TLI_TLIPS ((TLint4) 0, " - ", (TLint2) rccf);
			TL_TLI_TLIPS ((TLint4) 0, endline, (TLint2) rccf);
			TL_TLI_TLIPS ((TLint4) 0, " of ", (TLint2) rccf);
			TL_TLI_TLIPS ((TLint4) 0, srcfile, (TLint2) rccf);
			TL_TLI_TLIPK ((TLint2) rccf);
			TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "<pre>", (TLint2) rccf);
			TL_TLI_TLIPK ((TLint2) rccf);
			for(;;) {
			    TLint4	lengthline;
			    if (TL_TLI_TLIEOF((TLint4) ccf)) {
				break;
			    };
			    for(;;) {
				TL_TLI_TLISS ((TLint4) ccf, (TLint2) 1);
				TL_TLI_TLIGSS((TLint4) 4095, line, (TLint2) ccf);
				if (TL_TLI_TLIEOF((TLint4) ccf) || (TL_TLS_TLSLEN(line) < 4095)) {
				    break;
				};
				{
				    TLstring	__x108;
				    TL_TLS_TLSBXX(__x108, (TLint4) 1000, (TLint4) 1, line);
				    {
					TLstring	__x109;
					encode(__x108, __x109);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x109, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x110;
				    TL_TLS_TLSBXX(__x110, (TLint4) 2000, (TLint4) 1001, line);
				    {
					TLstring	__x111;
					encode(__x110, __x111);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x111, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x112;
				    TL_TLS_TLSBXX(__x112, (TLint4) 3000, (TLint4) 2001, line);
				    {
					TLstring	__x113;
					encode(__x112, __x113);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x113, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x114;
				    TL_TLS_TLSBXS(__x114, (TLint4) 0, (TLint4) 3001, line);
				    {
					TLstring	__x115;
					encode(__x114, __x115);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x115, (TLint2) rccf);
				    };
				};
			    };
			    if (strcmp(line, "</source>") == 0) {
				break;
			    };
			    lengthline = TL_TLS_TLSLEN(line);
			    if (lengthline > 1000) {
				{
				    TLstring	__x116;
				    TL_TLS_TLSBXX(__x116, (TLint4) 1000, (TLint4) 1, line);
				    {
					TLstring	__x117;
					encode(__x116, __x117);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x117, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x118;
				    TL_TLS_TLSBXX(__x118, (TLint4) 2000, (TLint4) 1001, line);
				    {
					TLstring	__x119;
					encode(__x118, __x119);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x119, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x120;
				    TL_TLS_TLSBXX(__x120, (TLint4) 3000, (TLint4) 2001, line);
				    {
					TLstring	__x121;
					encode(__x120, __x121);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x121, (TLint2) rccf);
				    };
				};
				{
				    TLstring	__x122;
				    TL_TLS_TLSBXS(__x122, (TLint4) 0, (TLint4) 3001, line);
				    {
					TLstring	__x123;
					encode(__x122, __x123);
					TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					TL_TLI_TLIPS ((TLint4) 0, __x123, (TLint2) rccf);
				    };
				};
			    } else {
				if (lengthline > 2000) {
				    {
					TLstring	__x124;
					TL_TLS_TLSBXX(__x124, (TLint4) 1000, (TLint4) 1, line);
					{
					    TLstring	__x125;
					    encode(__x124, __x125);
					    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					    TL_TLI_TLIPS ((TLint4) 0, __x125, (TLint2) rccf);
					};
				    };
				    {
					TLstring	__x126;
					TL_TLS_TLSBXX(__x126, (TLint4) 2000, (TLint4) 1001, line);
					{
					    TLstring	__x127;
					    encode(__x126, __x127);
					    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					    TL_TLI_TLIPS ((TLint4) 0, __x127, (TLint2) rccf);
					};
				    };
				    {
					TLstring	__x128;
					TL_TLS_TLSBXS(__x128, (TLint4) 0, (TLint4) 2001, line);
					{
					    TLstring	__x129;
					    encode(__x128, __x129);
					    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					    TL_TLI_TLIPS ((TLint4) 0, __x129, (TLint2) rccf);
					};
				    };
				} else {
				    if (lengthline > 1000) {
					{
					    TLstring	__x130;
					    TL_TLS_TLSBXX(__x130, (TLint4) 1000, (TLint4) 1, line);
					    {
						TLstring	__x131;
						encode(__x130, __x131);
						TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
						TL_TLI_TLIPS ((TLint4) 0, __x131, (TLint2) rccf);
					    };
					};
					{
					    TLstring	__x132;
					    TL_TLS_TLSBXS(__x132, (TLint4) 0, (TLint4) 1001, line);
					    {
						TLstring	__x133;
						encode(__x132, __x133);
						TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
						TL_TLI_TLIPS ((TLint4) 0, __x133, (TLint2) rccf);
					    };
					};
				    } else {
					{
					    TLstring	__x134;
					    encode(line, __x134);
					    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
					    TL_TLI_TLIPS ((TLint4) 0, __x134, (TLint2) rccf);
					    TL_TLI_TLIPK ((TLint2) rccf);
					};
				    };
				};
			    };
			};
			TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "</pre>", (TLint2) rccf);
			TL_TLI_TLIPK ((TLint2) rccf);
			TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "</td></tr>", (TLint2) rccf);
			TL_TLI_TLIPK ((TLint2) rccf);
		    };
		    if (strcmp(line, "</source>") != 0) {
			TL_TLI_TLISS ((TLint4) 0, (TLint2) 2);
			TL_TLI_TLIPS ((TLint4) 0, "*** Error: clone source file synchronization error", (TLint2) 0);
			TL_TLI_TLIPK ((TLint2) 0);
			TL_TLE_TLEQUIT ((TLint4) 1, (char *) 0, 0);
		    };
		};
		if ((strcmp(line, "</clone>") != 0) && (strcmp(line, "</class>") != 0)) {
		    TL_TLI_TLISS ((TLint4) 0, (TLint2) 2);
		    TL_TLI_TLIPS ((TLint4) 0, "*** Error: clone pair / class file synchronization error", (TLint2) 0);
		    TL_TLI_TLIPK ((TLint2) 0);
		    TL_TLE_TLEQUIT ((TLint4) 1, (char *) 0, 0);
		};
		TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
		TL_TLI_TLIPS ((TLint4) 0, "</table>", (TLint2) rccf);
		TL_TLI_TLIPK ((TLint2) rccf);
	    };
	};
    };
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</body>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLISS ((TLint4) rccf, (TLint2) 2);
    TL_TLI_TLIPS ((TLint4) 0, "</html>", (TLint2) rccf);
    TL_TLI_TLIPK ((TLint2) rccf);
    TL_TLI_TLICL ((TLint4) ccf);
    TL_TLI_TLICL ((TLint4) rccf);
}
