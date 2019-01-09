<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0">
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="mapdb">
    <office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0" xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0" xmlns:math="http://www.w3.org/1998/Math/MathML" xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0" xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0" xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer" xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events" xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rpt="http://openoffice.org/2005/report" xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#" xmlns:officeooo="http://openoffice.org/2009/office" xmlns:tableooo="http://openoffice.org/2009/table" xmlns:drawooo="http://openoffice.org/2010/draw" xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0" xmlns:loext="urn:org:documentfoundation:names:experimental:office:xmlns:loext:1.0" xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0" xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0" xmlns:css3t="http://www.w3.org/TR/css3-text/" office:version="1.2">
      <office:scripts/>
      <office:font-face-decls>
        <style:font-face style:name="OpenSymbol" svg:font-family="OpenSymbol" style:font-charset="x-symbol"/>
        <style:font-face style:name="Arial" svg:font-family="Arial, Helvetica, sans-serif"/>
        <style:font-face style:name="Arial2" svg:font-family="Arial" style:font-family-generic="swiss"/>
        <style:font-face style:name="Courier New" svg:font-family="&apos;Courier New&apos;" style:font-family-generic="modern" style:font-pitch="fixed"/>
        <style:font-face style:name="Liberation Serif" svg:font-family="&apos;Liberation Serif&apos;" style:font-family-generic="roman" style:font-pitch="variable"/>
        <style:font-face style:name="Liberation Sans" svg:font-family="&apos;Liberation Sans&apos;" style:font-family-generic="swiss" style:font-pitch="variable"/>
        <style:font-face style:name="Arial1" svg:font-family="Arial" style:font-family-generic="system" style:font-pitch="variable"/>
        <style:font-face style:name="Microsoft YaHei" svg:font-family="&apos;Microsoft YaHei&apos;" style:font-family-generic="system" style:font-pitch="variable"/>
        <style:font-face style:name="SimSun" svg:font-family="SimSun" style:font-family-generic="system" style:font-pitch="variable"/>
      </office:font-face-decls>
      <office:automatic-styles>
        <style:style style:name="P1" style:family="paragraph" style:parent-style-name="Text_20_body">
          <style:text-properties style:font-name="Courier New" style:font-name-asian="Courier New"/>
        </style:style>
        <style:style style:name="P2" style:family="paragraph" style:parent-style-name="Text_20_body" style:list-style-name="L1">
          <style:text-properties style:font-name="Courier New" officeooo:paragraph-rsid="001f7694" style:font-name-asian="Courier New"/>
        </style:style>
        <style:style style:name="P3" style:family="paragraph" style:parent-style-name="Heading_20_2">
          <style:paragraph-properties fo:text-align="center" style:justify-single-word="false"/>
          <style:text-properties style:font-name="Courier New" officeooo:paragraph-rsid="001f7694" style:font-name-asian="Courier New"/>
        </style:style>
        <style:style style:name="T1" style:family="text">
          <style:text-properties fo:font-variant="normal" fo:text-transform="none" fo:color="#aeaedd" style:font-name="Arial" fo:font-size="7.80000019073486pt" fo:letter-spacing="normal" fo:font-style="normal" fo:font-weight="normal"/>
        </style:style>
        <text:list-style style:name="L1">
          <text:list-level-style-bullet text:level="1" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="0.4909in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="2" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="0.7854in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="3" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="1.2764in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="4" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="1.7673in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="5" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="2.2583in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="6" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="2.7492in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="7" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="3.2402in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="8" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="3.7315in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="9" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="4.2224in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
          <text:list-level-style-bullet text:level="10" text:style-name="Bullet_20_Symbols" style:num-suffix="." text:bullet-char="•">
            <style:list-level-properties text:space-before="4.7134in" text:min-label-width="0.1965in"/>
          </text:list-level-style-bullet>
        </text:list-style>
      </office:automatic-styles>
      <office:body>
        <office:text>
          <text:sequence-decls>
            <text:sequence-decl text:display-outline-level="0" text:name="Illustration"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Table"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Text"/>
            <text:sequence-decl text:display-outline-level="0" text:name="Drawing"/>
          </text:sequence-decls>

          <xsl:apply-templates select="@* | node()"/>

        </office:text>
      </office:body>
    </office:document-content>
  </xsl:template>

  <xsl:template match="map">
    <text:h text:style-name="P3" text:outline-level="2">
      <xsl:value-of select="title/name" />
    </text:h>
    <text:p text:style-name="P1">
      <xsl:value-of select="title/description" />  
    </text:p>
    <text:list xml:id="list171931995956714" text:continue-numbering="true" text:style-name="L1">
      <text:list-item>
        <text:p text:style-name="P2">
          Size: <xsl:value-of select="size/@x"/>×<xsl:value-of select="size/@y" />
        </text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P2">
          Tileset: <xsl:value-of select="features/@tileset" />
        </text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P2">
          Players:
          <xsl:choose>
            <xsl:when test="features/@minPlayers = features/@maxPlayers">
              <xsl:value-of select="features/@minPlayers" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="features/@minPlayers" />
              -
              <xsl:value-of select="features/@maxPlayers" />
            </xsl:otherwise>
          </xsl:choose>
        </text:p>
      </text:list-item>
      <xsl:if test="features/@teams">
        <text:list-item>
          <text:p text:style-name="P2">
            Teams: <xsl:value-of select="features/@teams" />
          </text:p>
        </text:list-item>
      </xsl:if>
      <xsl:if test="features/@useMapSettings='true'">
        <text:list-item>
          <text:p text:style-name="P2">
            Use map settings
          </text:p>
        </text:list-item>
      </xsl:if>
      <xsl:if test="features/@island='true'">
        <text:list-item>
          <text:p text:style-name="P2">
            Island map
          </text:p>
        </text:list-item>
      </xsl:if>
      <xsl:if test="features/@ladder='true'">
        <text:list-item>
          <text:p text:style-name="P2">
            Official Ladder Map
          </text:p>
        </text:list-item>
      </xsl:if>
      <text:list-item>
        <text:p text:style-name="P2">
          Game:
          <xsl:choose>
            <xsl:when test="game/@versionId">
              <xsl:value-of select="//versions/version[@id=current()/game/@versionId]/title/name" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//games/game[@id=current()/game/@gameId]/title/name" />
            </xsl:otherwise>
          </xsl:choose>
        </text:p>
      </text:list-item>
      <text:list-item>
        <text:p text:style-name="P2">
          Author:
          <xsl:value-of select="//authors/author[@id=current()/author/@authorId]/title/name" />
        </text:p>
      </text:list-item>
      <xsl:if test="features/@ladder='true'">
        <text:list-item>
          <text:p text:style-name="P2">
            Release date:
            <xsl:value-of select="release" />
          </text:p>
        </text:list-item>
      </xsl:if>
    </text:list>
  </xsl:template>

  <xsl:template match="author" />

  <xsl:template match="game" />
</xsl:stylesheet>
