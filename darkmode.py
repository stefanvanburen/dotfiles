#!/usr/bin/env python3

import asyncio
import iterm2

DARK_MODE_PROFILE="Solarized Dark"
LIGHT_MODE_PROFILE="Solarized Light"

async def findProfileByName(connection, name):
    partialProfiles = await iterm2.PartialProfile.async_query(connection)
    for partial in partialProfiles:
        if partial.name == name:
            return await partial.async_get_full_profile()

async def setProfileForAllSessions(app, profile):
    for window in app.windows:
        for tab in window.tabs:
            for session in tab.sessions:
                await session.async_set_profile(profile)

async def main(connection):
    app = await iterm2.async_get_app(connection)

    async with iterm2.VariableMonitor(connection, iterm2.VariableScopes.APP, "effectiveTheme", None) as mon:
        while True:
            # Block until theme changes
            theme = await mon.async_get()

            # Themes have space-delimited attributes, one of which will be light or dark.
            parts = theme.split(" ")
            if "dark" in parts:
                name = DARK_MODE_PROFILE
            else:
                name = LIGHT_MODE_PROFILE

            profile = await findProfileByName(connection, name)
            if profile:
                await setProfileForAllSessions(app, profile)

iterm2.run_forever(main)

