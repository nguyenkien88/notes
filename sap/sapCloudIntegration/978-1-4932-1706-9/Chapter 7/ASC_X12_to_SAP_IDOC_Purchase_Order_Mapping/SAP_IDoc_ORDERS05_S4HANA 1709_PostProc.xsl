<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns="urn:sap.com:typesystem:b2b:310:sap_idoc" xmlns:tns="urn:sap.com:typesystem:b2b:310:sap_idoc" exclude-result-prefixes="tns" version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:output encoding="UTF-8" method="xml" version="1.0"/><xsl:template match="/node()"><xsl:variable name="vThisNode" select="name()"/><xsl:variable name="vPhaseIDoc"><xsl:element name="{$vThisNode}"><xsl:element name="IDOC"><xsl:attribute name="BEGIN"><xsl:value-of select="'1'"/></xsl:attribute><xsl:apply-templates mode="mPrepare" select="node()"/></xsl:element></xsl:element></xsl:variable><xsl:variable name="vGroupSegTags" select="'/ORDERS05/IDOC/E1EDKA1, /ORDERS05/IDOC/E1EDKA1, /ORDERS05/IDOC/E1EDKA1, /ORDERS05/IDOC/E1EDP01, '"/><xsl:variable name="vSegmentTags" select="'EDI_DC40, E1EDK01, E1EDK14, E1EDK14, E1EDK14, E1EDK14, E1EDK03, E1EDK03, E1EDKA1, E1EDKA1, E1EDKA1, E1EDK02, E1EDK18, E1EDK18, E1EDP01, E1EDP20, E1EDP19, E1EDP19, E1EDS01, '"/><xsl:apply-templates mode="mPostProc" select="$vPhaseIDoc"><xsl:with-param name="pGroupSegTags" select="$vGroupSegTags"/><xsl:with-param name="pSegmentTags" select="$vSegmentTags"/><xsl:with-param name="pPath" select="''"/></xsl:apply-templates></xsl:template><xsl:template match="@*|node()" mode="mPostProc"><xsl:param name="pGroupSegTags"/><xsl:param name="pSegmentTags"/><xsl:param name="pPath"/><xsl:variable name="vTagPath" select="concat($pPath, '/', name())"/><xsl:variable name="vTagName" select="name()"/><xsl:choose><xsl:when test="contains($pGroupSegTags, concat($vTagPath, ','))"><xsl:copy><xsl:attribute name="SEGMENT"><xsl:value-of select="'1'"/></xsl:attribute><xsl:apply-templates mode="mPostProc" select="node()[name()=$vTagName]/*"><xsl:with-param name="pGroupSegTags" select="$pGroupSegTags"/><xsl:with-param name="pSegmentTags" select="$pSegmentTags"/><xsl:with-param name="pPath" select="concat($pPath, '/', name())"/></xsl:apply-templates><xsl:apply-templates mode="mPostProc" select="node()[not(name()=$vTagName)]"><xsl:with-param name="pGroupSegTags" select="$pGroupSegTags"/><xsl:with-param name="pSegmentTags" select="$pSegmentTags"/><xsl:with-param name="pPath" select="concat($pPath, '/', name())"/></xsl:apply-templates></xsl:copy></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="contains($pSegmentTags, concat($vTagName, ','))"><xsl:copy><xsl:attribute name="SEGMENT"><xsl:value-of select="'1'"/></xsl:attribute><xsl:apply-templates mode="mPostProc" select="node()"><xsl:with-param name="pGroupSegTags" select="$pGroupSegTags"/><xsl:with-param name="pSegmentTags" select="$pSegmentTags"/><xsl:with-param name="pPath" select="concat($pPath, '/', name())"/></xsl:apply-templates></xsl:copy></xsl:when><xsl:otherwise><xsl:copy><xsl:apply-templates mode="mPostProc" select="@*|node()"><xsl:with-param name="pGroupSegTags" select="$pGroupSegTags"/><xsl:with-param name="pSegmentTags" select="$pSegmentTags"/><xsl:with-param name="pPath" select="concat($pPath, '/', name())"/></xsl:apply-templates></xsl:copy></xsl:otherwise></xsl:choose></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="//*[contains(name(),'_gq_')]" mode="mPrepare"><xsl:call-template name="Convert_Node"><xsl:with-param name="pNodeName" select="substring-before(name(), '_gq_')"/></xsl:call-template></xsl:template><xsl:template match="//*[contains(name(),'_pq_')]" mode="mPrepare"><xsl:call-template name="Convert_Node"><xsl:with-param name="pNodeName" select="substring-before(name(), '_pq_')"/></xsl:call-template></xsl:template><xsl:template match="@*[contains(name(),'_pq_')]" mode="mPrepare"><xsl:call-template name="Convert_Attr"><xsl:with-param name="pAttrName" select="substring-before(name(), '_pq_')"/></xsl:call-template></xsl:template><xsl:template name="Convert_Node"><xsl:param name="pNodeName"/><xsl:if test="$pNodeName != ''"><xsl:element name="{$pNodeName}"><xsl:apply-templates mode="mPrepare" select="@*|node()"/></xsl:element></xsl:if></xsl:template><xsl:template name="Convert_Attr"><xsl:param name="pAttrName"/><xsl:if test="$pAttrName != ''"><xsl:attribute name="{$pAttrName}"><xsl:value-of select="."/></xsl:attribute></xsl:if></xsl:template><xsl:template match="@*|node()" mode="mPrepare"><xsl:copy><xsl:apply-templates mode="mPrepare" select="@*|node()"/></xsl:copy></xsl:template></xsl:stylesheet>