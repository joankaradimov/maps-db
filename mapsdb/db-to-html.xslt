<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="title">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="logo"/>
      </xsl:attribute>
      <xsl:attribute name="alt">
        <xsl:value-of select="name"/>
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template match="map">
    <xsl:apply-templates select="title" />
    <div>
      <b><xsl:value-of select="release" /></b>
    </div>
    <ul>
      <li>
        Size: <xsl:value-of select="size/@x"/>&#xd7;<xsl:value-of select="size/@y" />
      </li>
      <li>
        Tileset: <xsl:value-of select="features/@tileset" />
      </li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
