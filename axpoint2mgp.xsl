<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">

<xsl:output method="text"/>

<!-- fill in %pause here to have all points appear only on demand -->
<xsl:variable name="pause">
</xsl:variable>

<xsl:template match="/">%deffont "standard"   tfont "arial.ttf",   tmfont "kochi-mincho.ttf"
%deffont "thick"      tfont "arialb.ttf",      tmfont "goth.ttf"
%deffont "typewriter" tfont "courb.ttf", tmfont "goth.ttf"
%deffont "bold"       tfont "arialb.ttf", tmfont "goth.ttf"
%deffont "italic"     tfont "ariali.ttf", tmfont "goth.ttf"
%deffont "bolditalic"     tfont "arialz.ttf", tmfont "goth.ttf"
%default 1 area 90 90, leftfill, size 2, fore "white", back "black", font "thick"
%default 2 size 5, vgap 10, prefix " "
%default 3 size 2, bar "gray70", vgap 10
%default 4 size 5, fore "white", vgap 30, prefix " ", font "standard"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Default settings that are applied to TAB-indented lines.
%%
%tab 1 size 4, vgap 40, prefix "  ", icon box "green" 50
%tab 2 size 3, vgap 40, prefix "      ", icon arc "yellow" 50
%tab 3 size 2.5, vgap 40, prefix "            ", icon delta3 "white" 40
%%%%%%%%%%%%%%%%%%%%%%
<xsl:apply-templates select="slideshow"/>
</xsl:template>

<xsl:template match="slideshow">%page
%nodefault
%center, size 7, font "standard", fore "white", vgap 20

%size 7

<xsl:value-of select="title"/>

%fore "yellow", size 5
%size 5

<xsl:value-of select="metadata/speaker"/>
<xsl:text>
</xsl:text>
<xsl:value-of select="metadata/email"/>
<xsl:text>
</xsl:text>
<xsl:apply-templates select="slide|slideset"/>
<xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="slide">%page

<xsl:value-of select="title"/>
<xsl:text>

</xsl:text><xsl:apply-templates select="point|source-code|source_code"/>
</xsl:template>

<xsl:template match="point"><xsl:value-of select="$pause"/>
<xsl:choose>
<xsl:when test="@level = 1">
<xsl:text>	</xsl:text>
</xsl:when>
<xsl:when test="@level = 2">
<xsl:text>		</xsl:text>
</xsl:when>
<xsl:when test="@level = 3">
<xsl:text>			</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>	</xsl:text>
</xsl:otherwise>
</xsl:choose>
<xsl:apply-templates />
<xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="slideset">
<xsl:apply-templates select="slide"/>
</xsl:template>

<xsl:template match="source-code|source_code">%size 4, font "typewriter"
<xsl:value-of select="."/>
<xsl:text>
</xsl:text>
%font "standard"
</xsl:template>

<xsl:template match="text()">
<xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="span[@style = 'font-family: monospace']">
%font "typewriter"
%cont
 <xsl:value-of select="."/>
%font "standard"
%cont
 </xsl:template>

<xsl:template match="b">
%font "bold"
%cont
 <xsl:apply-templates/>
%font "standard"
%cont
 </xsl:template>

<xsl:template match="i">
%font "italic"
%cont
 <xsl:value-of select="."/>
%font "standard"
%cont
 </xsl:template>

<xsl:template match="b/i">
%font "bolditalic"
%cont
 <xsl:value-of select="."/>
%font "standard"
%cont
 </xsl:template>

</xsl:stylesheet>

