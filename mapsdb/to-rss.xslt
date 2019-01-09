<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0">
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="mapdb">
    <rss version="2.0">
      <channel>
        <title>Map Database</title>
        <description>Maps for RTS games</description>

        <xsl:apply-templates select="@* | node()"/>
      </channel>
    </rss>
  </xsl:template>

  <xsl:template match="map">
    <item>
      <title>
        Map: <xsl:value-of select="title/name" />
      </title>
      <description>
        <xsl:value-of select="title/description" />
      </description>
    </item>
  </xsl:template>

  <xsl:template match="author">
    <item>
      <title>
        Author: <xsl:value-of select="title/name" />
      </title>
      <link>
        <xsl:value-of select="url" />
      </link>
      <description>
        <xsl:value-of select="title/description" />
      </description>
      <pubDate>
        <xsl:value-of select="release" />
      </pubDate>
    </item>
  </xsl:template>

  <xsl:template match="game">
    <item>
      <title>
        Game: <xsl:value-of select="title/name" />
      </title>
      <link>
        <xsl:value-of select="url" />
      </link>
      <description>
        <xsl:value-of select="title/description" />
      </description>
    </item>
  </xsl:template>
</xsl:stylesheet>
