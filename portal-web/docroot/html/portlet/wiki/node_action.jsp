<%
/**
 * Copyright (c) 2000-2010 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/wiki/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

WikiNode node = (WikiNode)row.getObject();
%>

<liferay-ui:icon-menu>
	<c:if test="<%= WikiNodePermission.contains(permissionChecker, node, ActionKeys.UPDATE) %>">
		<portlet:renderURL var="editURL">
			<portlet:param name="struts_action" value="/wiki/edit_node" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="nodeId" value="<%= String.valueOf(node.getNodeId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon image="edit" url="<%= editURL %>" />
	</c:if>

	<c:if test="<%= WikiNodePermission.contains(permissionChecker, node, ActionKeys.PERMISSIONS) %>">
		<liferay-security:permissionsURL
			modelResource="<%= WikiNode.class.getName() %>"
			modelResourceDescription="<%= node.getName() %>"
			resourcePrimKey="<%= String.valueOf(node.getNodeId()) %>"
			var="permissionsURL"
		/>

		<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
	</c:if>

	<c:if test="<%= WikiNodePermission.contains(permissionChecker, node, ActionKeys.IMPORT) %>">
		<portlet:renderURL var="importURL">
			<portlet:param name="struts_action" value="/wiki/import_pages" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="nodeId" value="<%= String.valueOf(node.getNodeId()) %>" />
		</portlet:renderURL>

		<liferay-ui:icon image="post" message="import-pages" url="<%= importURL %>" />
	</c:if>

	<liferay-ui:icon image="rss" url='<%= themeDisplay.getPathMain() + "/wiki/rss?p_l_id=" + plid + "&nodeId=" + node.getNodeId() + rssURLParams %>' target="_blank" />

	<c:if test="<%= WikiNodePermission.contains(permissionChecker, node, ActionKeys.SUBSCRIBE) %>">
		<c:choose>
			<c:when test="<%= SubscriptionLocalServiceUtil.isSubscribed(user.getCompanyId(), user.getUserId(), WikiNode.class.getName(), node.getNodeId()) %>">
				<portlet:actionURL var="unsubscribeURL">
					<portlet:param name="struts_action" value="/wiki/edit_node" />
					<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.UNSUBSCRIBE %>" />
					<portlet:param name="redirect" value="<%= currentURL %>" />
					<portlet:param name="nodeId" value="<%= String.valueOf(node.getNodeId()) %>" />
				</portlet:actionURL>

				<liferay-ui:icon image="unsubscribe" url="<%= unsubscribeURL %>" />
			</c:when>
			<c:otherwise>
				<portlet:actionURL var="subscribeURL">
					<portlet:param name="struts_action" value="/wiki/edit_node" />
					<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.SUBSCRIBE %>" />
					<portlet:param name="redirect" value="<%= currentURL %>" />
					<portlet:param name="nodeId" value="<%= String.valueOf(node.getNodeId()) %>" />
				</portlet:actionURL>

				<liferay-ui:icon image="subscribe" url="<%= subscribeURL %>" />
			</c:otherwise>
		</c:choose>
	</c:if>

	<c:if test="<%= WikiNodePermission.contains(permissionChecker, node, ActionKeys.DELETE) %>">
		<portlet:actionURL var="deleteURL">
			<portlet:param name="struts_action" value="/wiki/edit_node" />
			<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.DELETE %>" />
			<portlet:param name="redirect" value="<%= currentURL %>" />
			<portlet:param name="nodeId" value="<%= String.valueOf(node.getNodeId()) %>" />
		</portlet:actionURL>

		<liferay-ui:icon-delete url="<%= deleteURL %>" />
	</c:if>
</liferay-ui:icon-menu>