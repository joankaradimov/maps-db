<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" />

  <xsl:template match="mapdb">
    <style>
      body {
        background-color: black;
        color: gray;
      }

      .small-images img {
        width: 200px;
      }
    </style>
    <xsl:apply-templates select="@* | node()"/>
  </xsl:template>

  <xsl:template match="title">
    <xsl:choose>
      <xsl:when test="logo">
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="logo"/>
          </xsl:attribute>
          <xsl:attribute name="alt">
            <xsl:value-of select="name"/>
          </xsl:attribute>
        </img>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="downloads">
    <xsl:for-each select="full">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download
              <xsl:value-of select="../../title/name" />
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>

    <xsl:for-each select="demo">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download <xsl:value-of select="../../title/name" /> demo
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>

    <xsl:for-each select="patch">
      <div>
        <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="text()" />
          </xsl:attribute>

          <xsl:choose>
            <xsl:when test="@name">
              <xsl:value-of select="@name" />
            </xsl:when>
            <xsl:otherwise>
              Download <xsl:value-of select="../../title/name" /> patch
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="map">
    <table width="100%">
      <tr>
        <td colspan="2">
          <h1>
            <xsl:apply-templates select="title" />
          </h1>
        </td>
        <td rowspan="3" width="100%">
          <div>
            <xsl:value-of select="title/description" />
          </div>
          <ul>
            <li>
              Size: <xsl:value-of select="size/@x"/>&#xd7;<xsl:value-of select="size/@y" />
            </li>
            <li>
              Tileset: <xsl:value-of select="features/@tileset" />
            </li>
            <li>
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
            </li>
            <xsl:if test="features/@teams">
              <li>
                Teams: <xsl:value-of select="features/@teams" />
              </li>
            </xsl:if>
            <xsl:if test="features/@useMapSettings='true'">
              <li>Use map settings</li>
            </xsl:if>
            <xsl:if test="features/@island='true'">
              <li>Island map</li>
            </xsl:if>
            <xsl:if test="features/@ladder='true'">
              <li>Official Ladder Map</li>
            </xsl:if>
            <xsl:if test="release">
              <li>Released: <xsl:value-of select="release" /></li>
            </xsl:if>
          </ul>

          <xsl:apply-templates select="downloads" />
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <xsl:if test="preview">
            <img alt="Map Preview" width="400px">
              <xsl:attribute name="src">
                <xsl:value-of select="preview" />
              </xsl:attribute>
            </img>
          </xsl:if>
        </td>
      </tr>
      <tr class="small-images">
        <td>
          <xsl:apply-templates select="//authors/author[@id=current()/author/@authorId]/title">
            <xsl:with-param name="width" select="'200px'" />
          </xsl:apply-templates>
        </td>
        <td>
          <xsl:choose>
            <xsl:when test="game/@versionId">
              <xsl:apply-templates select="//versions/version[@id=current()/game/@versionId]/title" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="//games/game[@id=current()/game/@gameId]/title" />
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
    <hr></hr>
  </xsl:template>

  <xsl:template match="authors" />

  <xsl:template match="games" />
</xsl:stylesheet>
